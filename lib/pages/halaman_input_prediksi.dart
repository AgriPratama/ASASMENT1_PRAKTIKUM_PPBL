import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../models/hasil_prediksi.dart';

class HalamanInputPrediksi extends StatelessWidget {
  const HalamanInputPrediksi({super.key});

  Future<void> _bukaForm(BuildContext context) async {
    final hasil = await Navigator.pushNamed(context, AppRoutes.inputPrediksi);

    if (!context.mounted) return;

    if (hasil is HasilPrediksi) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data ${hasil.tanaman} berhasil divalidasi. '
            'Status: ${hasil.status}. '
            'Riwayat akan dikelola pada Tahap 3.',
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Prediksi Mikroklimat',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan hasil prediksi suhu dan kelembapan '
              'untuk mengetahui status mikroklimat tanaman.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => _bukaForm(context),
              icon: const Icon(Icons.add),
              label: const Text('Prediksi Baru'),
            ),
          ],
        ),
      ),
    );
  }
}
