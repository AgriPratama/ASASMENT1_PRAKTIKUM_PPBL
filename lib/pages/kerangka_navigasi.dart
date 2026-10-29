import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'halaman_beranda.dart';
import 'halaman_input_prediksi.dart';
import 'halaman_statistik.dart';
import 'halaman_pengaturan.dart';
import '../state/prediksi_model.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int indeksAktif = 0;

  final List<String> namaTab = const [
    'Beranda',
    'Prediksi',
    'Statistik',
    'Pengaturan',
  ];

  final List<Widget> halaman = const [
    HalamanBeranda(),
    HalamanInputPrediksi(),
    HalamanStatistik(),
    HalamanPengaturan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<PrediksiModel>(
      builder: (context, model, child) {
        final jumlahPerluTindakan = model.jumlahPerluTindakan;

        return Scaffold(
          appBar: AppBar(
            title: Text('AgriClima - ${namaTab[indeksAktif]}'),
            centerTitle: false,
          ),

          // IndexedStack menjaga state setiap tab.
          body: IndexedStack(index: indeksAktif, children: halaman),

          // Navigasi bawah dengan badge pada tab Prediksi.
          bottomNavigationBar: NavigationBar(
            selectedIndex: indeksAktif,
            onDestinationSelected: (indeks) {
              setState(() {
                indeksAktif = indeks;
              });
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda',
              ),

              NavigationDestination(
                icon: Badge(
                  isLabelVisible: jumlahPerluTindakan > 0,
                  label: Text('$jumlahPerluTindakan'),
                  child: const Icon(Icons.menu),
                ),
                selectedIcon: Badge(
                  isLabelVisible: jumlahPerluTindakan > 0,
                  label: Text('$jumlahPerluTindakan'),
                  child: const Icon(Icons.eco),
                ),
                label: 'Prediksi',
              ),

              const NavigationDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart),
                label: 'Statistik',
              ),

              const NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Pengaturan',
              ),
            ],
          ),
        );
      },
    );
  }
}
