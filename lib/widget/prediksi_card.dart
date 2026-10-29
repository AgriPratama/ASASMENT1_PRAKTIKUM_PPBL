import 'package:flutter/material.dart';

import '../models/hasil_prediksi.dart';

class PrediksiCard extends StatelessWidget {
  final HasilPrediksi data;
  final VoidCallback onHapus;

  const PrediksiCard({super.key, required this.data, required this.onHapus});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final warnaStatus = switch (data.status) {
      'Kering' => Colors.red,
      'Optimal' => Colors.green,
      _ => Colors.orange,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.eco, color: warnaStatus),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${data.petak} • ${data.tanaman}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  tooltip: 'Hapus prediksi',
                  onPressed: onHapus,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Chip(
              avatar: Icon(
                data.status == 'Kering'
                    ? Icons.water_drop_outlined
                    : data.status == 'Optimal'
                    ? Icons.check_circle_outline
                    : Icons.water,
                color: warnaStatus,
              ),
              label: Text(data.status),
              side: BorderSide(color: warnaStatus),
            ),
            const SizedBox(height: 8),
            Text(
              'Kelembapan tanah: '
              '${data.kelembapanTanah.toStringAsFixed(1)}%',
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: data.kelembapanTanah / 100,
              color: warnaStatus,
              backgroundColor: colors.surfaceContainerHighest,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12),
            Text('Suhu udara: ${data.suhuUdara} °C'),
            Text('Kelembapan udara: ${data.kelembapanUdara}%'),
            const SizedBox(height: 8),
            Text('Rekomendasi: ${data.rekomendasi}'),
            const SizedBox(height: 4),
            Text('Catatan: ${data.catatanPerawatan}'),
            const SizedBox(height: 8),
            Text(
              'Petugas: ${data.namaPetugas}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Waktu: ${data.waktu.toLocal().toString().substring(0, 16)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
