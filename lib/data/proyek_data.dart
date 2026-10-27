import 'package:flutter/material.dart';

class Proyek {
  final String judul;
  final String deskripsi;
  final IconData ikon;

  const Proyek({
    required this.judul,
    required this.deskripsi,
    required this.ikon,
  });
}

const daftarProyek = [
  Proyek(
    judul: 'Aplikasi Absensi Kampus',
    deskripsi: 'Presensi mahasiswa berbasis lokasi.',
    ikon: Icons.fingerprint,
  ),
  Proyek(
    judul: 'Katalog UMKM',
    deskripsi: 'Etalase produk UMKM lokal dengan pencarian.',
    ikon: Icons.storefront,
  ),
  Proyek(
    judul: 'Pengingat Belajar',
    deskripsi: 'Jadwal belajar dengan notifikasi harian.',
    ikon: Icons.alarm,
  ),
  Proyek(
    judul: 'Catatan Keuangan',
    deskripsi: 'Mencatat pemasukan dan pengeluaran harian.',
    ikon: Icons.account_balance_wallet,
  ),
];