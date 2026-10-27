import 'package:flutter/material.dart';
import '../pages/tentang_page.dart';

class AppDrawer extends StatelessWidget {
  final ValueChanged<int> onPilihTab; // Callback untuk mengirim index tab

  const AppDrawer({super.key, required this.onPilihTab});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Agnes Riskiyah'),
            accountEmail: Text('e41250685@student.polije.ac.id'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://picsum.photos/seed/profile/300/300',
              ),
            ),
          ),
         
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Proyek Saya'),
            onTap: () {
              Navigator.pop(context); // 1. Tutup drawer
              onPilihTab(1);          // 2. Pindah ke tab Proyek
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.pop(context); 
              Navigator.push(         
                context,
                MaterialPageRoute(builder: (context) => const TentangPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Bagikan Profil'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tautan profil disalin')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Keluar'),
            onTap: () {
              Navigator.pop(context);
              _konfirmasiKeluar(context);
            },
          ),
        ],
      ),
    );
  }

  void _konfirmasiKeluar(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar?'),
        content: const Text('Kamu akan keluar dari aplikasi (simulasi).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kamu telah keluar')),
              );
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}