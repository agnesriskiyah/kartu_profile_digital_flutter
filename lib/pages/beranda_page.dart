import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/seed/profile/300/300',
                  ),
                ),
                const SizedBox(height: 16),
                Text('Agnes Riskiyah', style: tema.headlineSmall),
                const SizedBox(height: 4),
                Text('Mahasiswa Teknik Informatika', style: tema.bodyMedium),
                const SizedBox(height: 12),
                const Text(
                  'Sedang belajar Flutter. '
                  'Suka membangun aplikasi mobile yang sederhana, rapi, dan berguna. '
                  'Sedang mengerjakan proyek akhir semester bertema kartu profil digital.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}