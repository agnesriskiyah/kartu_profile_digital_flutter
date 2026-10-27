import 'package:flutter/material.dart';
import '../data/proyek_data.dart';

class ProyekDetailPage extends StatelessWidget {
  final Proyek proyek;

  const ProyekDetailPage({super.key, required this.proyek});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(proyek.judul)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'ikon-${proyek.judul}',
              child: Icon(proyek.ikon, size: 64),
            ),
            const SizedBox(height: 16),
            Text(
              proyek.judul,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(proyek.deskripsi),
          ],
        ),
      ),
    );
  }
}