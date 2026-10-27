import 'package:flutter/material.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  bool _notifikasi = false;
  bool _profilPublik = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Notifikasi'),
          value: _notifikasi,
          onChanged: (nilai) => setState(() => _notifikasi = nilai),
        ),
        SwitchListTile(
          title: const Text('Profil Publik'),
          value: _profilPublik,
          onChanged: (nilai) => setState(() => _profilPublik = nilai),
        ),
      ],
    );
  }
}