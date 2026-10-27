import 'package:flutter/material.dart';
import 'data/destinasi.dart';
import 'widgets/app_drawer.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _indeks = 0;

  void _pilihTab(int i) => setState(() => _indeks = i);

  @override
  Widget build(BuildContext context) {
    final layarLebar = MediaQuery.sizeOf(context).width >= 600;

    return PopScope(
      canPop: _indeks == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
          _scaffoldKey.currentState?.closeDrawer();
        } else {
          _pilihTab(0);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text(daftarDestinasi[_indeks].label)),
        drawer: AppDrawer(onPilihTab: _pilihTab),
        body: Row(
          children: [
            if (layarLebar)
              NavigationRail(
                selectedIndex: _indeks,
                onDestinationSelected: _pilihTab,
                labelType: NavigationRailLabelType.all,
                destinations: [
                  for (final d in daftarDestinasi)
                    NavigationRailDestination(
                      icon: Icon(d.ikon),
                      selectedIcon: Icon(d.ikonAktif),
                      label: Text(d.label),
                    ),
                ],
              ),
            Expanded(
              child: IndexedStack(
                index: _indeks,
                children: [for (final d in daftarDestinasi) d.halaman],
              ),
            ),
          ],
        ),
        bottomNavigationBar: layarLebar
            ? null
            : NavigationBar(
                selectedIndex: _indeks,
                onDestinationSelected: _pilihTab,
                destinations: [
                  for (final d in daftarDestinasi)
                    NavigationDestination(
                      icon: Icon(d.ikon),
                      selectedIcon: Icon(d.ikonAktif),
                      label: d.label,
                    ),
                ],
              ),
      ),
    );
  }
}