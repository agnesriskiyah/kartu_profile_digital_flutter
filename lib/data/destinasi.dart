import 'package:flutter/material.dart';
import '../pages/beranda_page.dart';
import '../pages/kontak_page.dart';
import '../pages/pengaturan_page.dart';
import '../pages/proyek_page.dart';

class Destinasi {
  final String label;
  final IconData ikon;
  final IconData ikonAktif;
  final Widget halaman;

  const Destinasi({
    required this.label,
    required this.ikon,
    required this.ikonAktif,
    required this.halaman,
  });
}

const daftarDestinasi = [
  Destinasi(
    label: 'Beranda',
    ikon: Icons.person_outline,
    ikonAktif: Icons.person,
    halaman: BerandaPage(),
  ),
  Destinasi(
    label: 'Proyek',
    ikon: Icons.work_outline,
    ikonAktif: Icons.work,
    halaman: ProyekPage(),
  ),
  Destinasi(
    label: 'Kontak',
    ikon: Icons.contacts_outlined,
    ikonAktif: Icons.contacts,
    halaman: KontakPage(),
  ),
  Destinasi(
    label: 'Pengaturan',
    ikon: Icons.settings_outlined,
    ikonAktif: Icons.settings,
    halaman: PengaturanPage(),
  ),
];