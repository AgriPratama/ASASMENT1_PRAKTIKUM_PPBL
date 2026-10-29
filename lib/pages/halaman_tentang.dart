import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang AgriClima')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'AgriClima LSTM',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          const Text(
            'AgriClima LSTM adalah aplikasi simulasi '
            'pencatatan prediksi mikroklimat tanaman '
            'untuk membantu pemantauan kondisi lahan.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Card(
            child: ListTile(
              leading: Icon(Icons.memory),
              title: Text('Teknologi'),
              subtitle: Text('Long Short-Term Memory (LSTM)'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Periode Prediksi'),
              subtitle: Text('24 jam ke depan'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.water_drop),
              title: Text('Parameter Mikroklimat'),
              subtitle: Text(
                'Suhu udara, kelembapan udara, '
                'dan kelembapan tanah',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
