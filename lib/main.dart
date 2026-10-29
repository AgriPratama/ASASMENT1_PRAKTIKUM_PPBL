import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/kerangka_navigasi.dart';
import 'pages/halaman_tentang.dart';
import 'pages/form_input_prediksi.dart';
import 'routes/app_routes.dart';
import 'state/prediksi_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider<PrediksiModel>(
      create: (_) => PrediksiModel(),
      child: const AgriClimaApp(),
    ),
  );
}

class AgriClimaApp extends StatelessWidget {
  const AgriClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriClima LSTM',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      themeMode: ThemeMode.light,

      initialRoute: AppRoutes.beranda,

      routes: {
        AppRoutes.beranda: (context) => const KerangkaNavigasi(),
        AppRoutes.tentang: (context) => const HalamanTentang(),
        AppRoutes.inputPrediksi: (context) => const FormInputPrediksi(),
      },
    );
  }
}
