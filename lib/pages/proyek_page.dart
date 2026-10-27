import 'package:flutter/material.dart';
import '../data/proyek_data.dart';
import 'proyek_detail_page.dart';

class ProyekPage extends StatelessWidget {
  const ProyekPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: daftarProyek.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final proyek = daftarProyek[index];
        return ListTile(
          leading: Hero(
            tag: 'ikon-${proyek.judul}',
            child: CircleAvatar(child: Icon(proyek.ikon)),
          ),
          title: Text(proyek.judul),
          subtitle: Text(proyek.deskripsi),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProyekDetailPage(proyek: proyek),
            ),
          ),
        );
      },
    );
  }
}