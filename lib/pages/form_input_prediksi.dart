import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hasil_prediksi.dart';
import '../state/prediksi_model.dart';

class FormInputPrediksi extends StatefulWidget {
  const FormInputPrediksi({super.key});

  @override
  State<FormInputPrediksi> createState() => _FormInputPrediksiState();
}

class _FormInputPrediksiState extends State<FormInputPrediksi> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _suhuController = TextEditingController();

  final TextEditingController _udaraController = TextEditingController();

  final TextEditingController _tanahController = TextEditingController();

  final TextEditingController _petugasController = TextEditingController();

  String _petak = 'Petak 1';
  String _tanaman = 'Padi';
  bool _dataBenar = false;
  bool _sedangMenyimpan = false;

  @override
  void dispose() {
    _suhuController.dispose();
    _udaraController.dispose();
    _tanahController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  // Validasi angka dan rentang nilai.
  String? _validasiAngka(
    String? value, {
    required String nama,
    required double min,
    required double max,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$nama wajib diisi';
    }

    final angka = double.tryParse(value.trim());

    if (angka == null || !angka.isFinite) {
      return '$nama harus berupa angka';
    }

    if (angka < min || angka > max) {
      return '$nama harus antara $min dan $max';
    }

    return null;
  }

  // Menampilkan dialog konfirmasi dan menyimpan prediksi.
  Future<void> _simpanPrediksi() async {
    if (_sedangMenyimpan) return;

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_dataBenar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Centang "Data sudah benar" terlebih dahulu.'),
        ),
      );
      return;
    }

    final hasil = HasilPrediksi(
      petak: _petak,
      tanaman: _tanaman,
      suhuUdara: double.parse(_suhuController.text.trim()),
      kelembapanUdara: double.parse(_udaraController.text.trim()),
      kelembapanTanah: double.parse(_tanahController.text.trim()),
      namaPetugas: _petugasController.text.trim(),
    );

    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Prediksi'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Petak: ${hasil.petak}'),
                Text('Tanaman: ${hasil.tanaman}'),
                Text('Suhu udara: ${hasil.suhuUdara} °C'),
                Text(
                  'Kelembapan udara: '
                  '${hasil.kelembapanUdara}%',
                ),
                Text(
                  'Kelembapan tanah: '
                  '${hasil.kelembapanTanah}%',
                ),
                Text('Petugas: ${hasil.namaPetugas}'),
                const Divider(height: 24),
                Text(
                  'Status: ${hasil.status}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Rekomendasi: ${hasil.rekomendasi}'),
                const SizedBox(height: 8),
                Text(
                  'Catatan perawatan: '
                  '${hasil.catatanPerawatan}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Ya, Simpan'),
            ),
          ],
        );
      },
    );

    if (!mounted || konfirmasi != true) {
      return;
    }

    setState(() {
      _sedangMenyimpan = true;
    });

    try {
      // Menyimpan data ke state aplikasi menggunakan Provider.
      context.read<PrediksiModel>().tambahPrediksi(hasil);

      if (!mounted) return;

      // Kembali ke halaman sebelumnya.
      Navigator.pop(context, hasil);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _sedangMenyimpan = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal menyimpan data: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Input Prediksi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Data Mikroklimat',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan hasil prediksi mikroklimat '
              'untuk menentukan status dan rekomendasi '
              'perawatan tanaman.',
            ),

            const SizedBox(height: 20),

            // Pilihan petak lahan.
            Text('Petak Lahan', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),

            RadioGroup<String>(
              groupValue: _petak,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _petak = value;
                  });
                }
              },
              child: const Column(
                children: [
                  RadioListTile<String>(
                    title: Text('Petak 1'),
                    value: 'Petak 1',
                  ),
                  RadioListTile<String>(
                    title: Text('Petak 2'),
                    value: 'Petak 2',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Pilihan tanaman.
            DropdownButtonFormField<String>(
              initialValue: _tanaman,
              decoration: const InputDecoration(
                labelText: 'Nama Tanaman',
                prefixIcon: Icon(Icons.eco),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Padi', child: Text('Padi')),
                DropdownMenuItem(value: 'Jagung', child: Text('Jagung')),
                DropdownMenuItem(value: 'Cabai', child: Text('Cabai')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _tanaman = value;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            // Input suhu udara.
            TextFormField(
              controller: _suhuController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Prediksi Suhu Udara (°C)',
                hintText: 'Contoh: 28.5',
                prefixIcon: Icon(Icons.thermostat),
                border: OutlineInputBorder(),
              ),
              validator: (value) => _validasiAngka(
                value,
                nama: 'Suhu udara',
                min: -100,
                max: 100,
              ),
            ),

            const SizedBox(height: 16),

            // Input kelembapan udara.
            TextFormField(
              controller: _udaraController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Prediksi Kelembapan Udara (%)',
                hintText: 'Contoh: 75',
                prefixIcon: Icon(Icons.cloud),
                border: OutlineInputBorder(),
              ),
              validator: (value) => _validasiAngka(
                value,
                nama: 'Kelembapan udara',
                min: 0,
                max: 100,
              ),
            ),

            const SizedBox(height: 16),

            // Input kelembapan tanah.
            TextFormField(
              controller: _tanahController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Prediksi Kelembapan Tanah (%)',
                hintText: 'Contoh: 55',
                prefixIcon: Icon(Icons.water_drop),
                border: OutlineInputBorder(),
              ),
              validator: (value) => _validasiAngka(
                value,
                nama: 'Kelembapan tanah',
                min: 0,
                max: 100,
              ),
            ),

            const SizedBox(height: 16),

            // Input nama petugas.
            TextFormField(
              controller: _petugasController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama Petugas',
                hintText: 'Masukkan nama petugas',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama petugas wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            // Checkbox persetujuan data.
            CheckboxListTile(
              value: _dataBenar,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: colors.primary,
              title: const Text('Data sudah benar'),
              onChanged: (value) {
                setState(() {
                  _dataBenar = value ?? false;
                });
              },
            ),

            const SizedBox(height: 20),

            // Tombol simpan.
            FilledButton.icon(
              onPressed: _sedangMenyimpan ? null : _simpanPrediksi,
              icon: const Icon(Icons.save),
              label: Text(
                _sedangMenyimpan ? 'Menyimpan...' : 'Simpan Prediksi',
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
