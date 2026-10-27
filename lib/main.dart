import 'package:flutter/material.dart';
import 'app_shell.dart';

void main() => runApp(const KartuProfilApp());

class KartuProfilApp extends StatelessWidget {
  const KartuProfilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Profil Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const AppShell(),
    );
  }
}