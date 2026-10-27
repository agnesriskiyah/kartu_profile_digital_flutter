import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/app_routes.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile _profile = defaultProfile;
  bool _isFollowing = false;
  int _followers = 330;
  bool _isBioExpanded = false;

  void _showSnack(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          action: action,
        ),
      );
  }

  void _openProjectDetail(Project project) {
    context.push(AppRoutes.projectDetail(project.id)); // ID di path
  }

  Future<void> _openEditProfile() async {
    // push<Profile>: hasil sudah bertipe Profile?, tidak perlu `is!`
    final result = await context.push<Profile>(
      AppRoutes.editProfile,
      extra: _profile, // objek dikirim lewat extra
    );
    if (!mounted || result == null) return;
    setState(() => _profile = result);
  }

  void _logout() {
    context.go(AppRoutes.splash); // stack dibersihkan, tanpa RemoveUntil
  }

  Future<bool> _showConfirmDialog({
    required String title,
    required String message,
    required String confirmLabel,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _setFollowing(bool value) {
    if (_isFollowing == value) return;
    setState(() {
      _isFollowing = value;
      _followers += value ? 1 : -1;
    });
  }

  Future<void> _onFollowPressed() async {
    if (!_isFollowing) {
      _setFollowing(true);
      _showSnack(
        'Kamu mulai mengikuti ${_profile.name}',
        action: SnackBarAction(
          label: 'BATAL',
          onPressed: () => _setFollowing(false),
        ),
      );
      return;
    }

    final confirmed = await _showConfirmDialog(
      title: 'Berhenti mengikuti?',
      message: 'Kamu tidak akan lagi melihat pembaruan dari ${_profile.name}.',
      confirmLabel: 'Berhenti',
    );
    if (!confirmed || !mounted) return;

    _setFollowing(false);
    _showSnack('Kamu berhenti mengikuti ${_profile.name}');
  }

  void _onSkillChanged(String skill, bool selected) {
    setState(() {
      final newSkills = Set<String>.from(_profile.skills);
      if (selected) {
        newSkills.add(skill);
      } else {
        newSkills.remove(skill);
      }
      _profile = _profile.copyWith(skills: newSkills);
    });
  }

  Future<void> _onResetPressed() async {
    final confirmed = await _showConfirmDialog(
      title: 'Reset pengaturan?',
      message: 'Semua pengaturan akan kembali ke nilai awal.',
      confirmLabel: 'Reset',
    );
    if (!confirmed || !mounted) return;

    setState(() {
      _profile = defaultProfile;
    });
    _showSnack('Pengaturan berhasil direset');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil Digital'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit profil',
            onPressed: _openEditProfile,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 48,
                backgroundImage:
                    NetworkImage('https://picsum.photos/seed/profile/300/300'),
              ),
            ),
            const SizedBox(height: 12),
            Text(_profile.name,
                textAlign: TextAlign.center, style: textTheme.headlineSmall),
            Text(_profile.status.label, textAlign: TextAlign.center),
            if (_profile.openToWork) ...[
              const SizedBox(height: 8),
              const Center(
                child: Chip(
                  avatar: Icon(Icons.work_outline, size: 18),
                  label: Text('Open to Work'),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const _StatItem(label: 'Postingan', value: '3'),
                    _StatItem(label: 'Pengikut', value: '$_followers'),
                    const _StatItem(label: 'Mengikuti', value: '163'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _isFollowing
                ? OutlinedButton.icon(
                    onPressed: _onFollowPressed,
                    icon: const Icon(Icons.check),
                    label: const Text('Mengikuti'),
                  )
                : FilledButton.icon(
                    onPressed: _onFollowPressed,
                    icon: const Icon(Icons.person_add),
                    label: const Text('Ikuti'),
                  ),
            const SizedBox(height: 16),
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => setState(() => _isBioExpanded = !_isBioExpanded),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tentang', style: textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        _profile.bio,
                        maxLines: _isBioExpanded ? null : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isBioExpanded ? 'Tutup' : 'Selengkapnya',
                        style: TextStyle(color: colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Keahlian', style: textTheme.titleMedium),
                    const SizedBox(height: 8),
                    if (_profile.skills.isEmpty)
                      const Text('Belum ada keahlian dipilih')
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final s in _profile.skills) Chip(label: Text(s)),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Bagian Daftar Proyek (Persiapan Lab 2)
            Text('Proyek', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final project in dummyProjects)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.folder_open),
                  title: Text(project.title),
                  subtitle: Text(project.techStack.join(' • ')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _openProjectDetail(project),
                ),
              ),
            const SizedBox(height: 16),
            _SettingsCard(
              openToWork: _profile.openToWork,
              onOpenToWorkChanged: (value) =>
                  setState(() => _profile = _profile.copyWith(openToWork: value)),
              allSkills: allSkillsList,
              selectedSkills: _profile.skills,
              onSkillChanged: _onSkillChanged,
              status: _profile.status,
              onStatusChanged: (value) =>
                  setState(() => _profile = _profile.copyWith(status: value)),
              onReset: _onResetPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: textTheme.titleLarge),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.openToWork,
    required this.onOpenToWorkChanged,
    required this.allSkills,
    required this.selectedSkills,
    required this.onSkillChanged,
    required this.status,
    required this.onStatusChanged,
    required this.onReset,
  });

  final bool openToWork;
  final ValueChanged<bool> onOpenToWorkChanged;
  final List<String> allSkills;
  final Set<String> selectedSkills;
  final void Function(String skill, bool selected) onSkillChanged;
  final ProfileStatus status;
  final ValueChanged<ProfileStatus> onStatusChanged;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pengaturan Profil', style: textTheme.titleMedium),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Open to Work'),
              subtitle: const Text('Tampilkan lencana di kartu profilmu'),
              value: openToWork,
              onChanged: onOpenToWorkChanged,
            ),
            const Divider(),
            const Text('Keahlian'),
            for (final skill in allSkills)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(skill),
                value: selectedSkills.contains(skill),
                onChanged: (value) => onSkillChanged(skill, value ?? false),
              ),
            const Divider(),
            const Text('Status'),
            DropdownButton<ProfileStatus>(
              isExpanded: true,
              value: status,
              items: [
                for (final s in ProfileStatus.values)
                  DropdownMenuItem(value: s, child: Text(s.label)),
              ],
              onChanged: (value) {
                if (value != null) onStatusChanged(value);
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onReset,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset pengaturan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}