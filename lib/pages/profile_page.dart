
import 'package:flutter/material.dart';

import '../models/profile_data.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileData _profile = const ProfileData(
    name: 'iyya_starlvy',
    email: 'iyya@example.com',
    phone: '081234567890',
    bio: 'Mahasiswa Teknik Informatika yang sedang belajar Flutter. '
        'Suka membangun aplikasi mobile yang sederhana, rapi, dan berguna. '
        'Sedang mengerjakan proyek akhir semester bertema kartu profil digital.',
  );

  bool _isFollowing = false;
  int _followers = 1200;
  bool _isBioExpanded = false;

  void _setFollowing(bool value) {
    if (_isFollowing == value) return;

    setState(() {
      _isFollowing = value;
      _followers += value ? 1 : -1;
    });
  }

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

  void _onFollowPressed() {
    if (_isFollowing) {
      _setFollowing(false);
      _showSnack('Kamu berhenti mengikuti ${_profile.name}');
    } else {
      _setFollowing(true);
      _showSnack(
        'Kamu mulai mengikuti ${_profile.name}',
        action: SnackBarAction(
          label: 'BATAL',
          onPressed: () => _setFollowing(false),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil Digital'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPVDU71xR7Cc1UImWIuccix__sg2rPrmKbNPL5KmZzI6OL_Ibe_3kV9P28&s=10',
                ),
              ),
            ),
            const SizedBox(height: 12),

            Text(
              _profile.name,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall,
            ),
            const Text(
              'Mahasiswa',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const _StatItem(
                      label: 'Postingan',
                      value: '1',
                    ),
                    _StatItem(
                      label: 'Pengikut',
                      value: '$_followers',
                    ),
                    const _StatItem(
                      label: 'Mengikuti',
                      value: '320',
                    ),
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Informasi Profil',
                        style: textTheme.titleMedium),
                    const SizedBox(height: 16),
                    const Icon(Icons.email_outlined, size: 20),
                    const SizedBox(height: 4),
                    Text(_profile.email),
                    const SizedBox(height: 12),
                    const Icon(Icons.phone_outlined, size: 20),
                    const SizedBox(height: 4),
                    Text(_profile.phone),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    _isBioExpanded = !_isBioExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tentang',
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _profile.bio,
                        maxLines: _isBioExpanded ? null : 2,
                        overflow: _isBioExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isBioExpanded ? 'Tutup' : 'Selengkapnya',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditProfilePage()),
          );
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profil'),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
  });

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
