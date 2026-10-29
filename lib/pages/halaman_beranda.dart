import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Selamat Datang di AgriClima LSTM',
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text(
          'Aplikasi untuk mencatat hasil prediksi mikrolat tanaman di lahan kelompok Tani Sri mulya '
          'agar kebuthan penyiraman tiap petak mudah dipantau.',
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.memory, size: 36, color: colors.primary),
                const SizedBox(height: 12),
                Text(
                  'Model LSTM (Deep Learning)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Memprediksi kondisi mikroklimat '
                  '24 jam ke depan berdasarkan data deret waktu.',
                ),
                const Divider(height: 24),
                const Text('3 Parameter Mikroklimat:'),
                const SizedBox(height: 8),
                const Text('• Suhu udara (°C)'),
                const Text('• Kelembapan udara (%)'),
                const Text('• Kelembapan tanah (%)'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Icon(Icons.info_outline, color: colors.primary),
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text('Pelajari tujuan dan teknologi AgriClima.'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.tentang);
            },
          ),
        ),
      ],
    );
  }
}
