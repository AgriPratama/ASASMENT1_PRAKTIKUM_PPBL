import 'dart:math';

import 'package:flutter/material.dart';

import '../models/hasil_prediksi.dart';

class PrediksiModel extends ChangeNotifier {
  final List<HasilPrediksi> _daftarPrediksi = [];
  final Random _random = Random();

  String _filterPetak = 'Semua';

  List<HasilPrediksi> get semuaPrediksi => List.unmodifiable(_daftarPrediksi);

  String get filterPetak => _filterPetak;

  List<HasilPrediksi> get daftarTerfilter {
    if (_filterPetak == 'Semua') {
      return semuaPrediksi;
    }

    return _daftarPrediksi.where((data) => data.petak == _filterPetak).toList();
  }

  int get total => _daftarPrediksi.length;

  int get jumlahOptimal => jumlahStatus('Optimal');

  int get jumlahPerluTindakan =>
      jumlahStatus('Kering') + jumlahStatus('Terlalu Lembap');

  int jumlahStatus(String status) {
    return _daftarPrediksi.where((data) => data.status == status).length;
  }

  void tambahPrediksi(HasilPrediksi data) {
    _daftarPrediksi.insert(0, data);
    notifyListeners();
  }

  void hapusPrediksi(HasilPrediksi data) {
    if (_daftarPrediksi.remove(data)) {
      notifyListeners();
    }
  }

  void hapusSemua() {
    if (_daftarPrediksi.isEmpty) return;

    _daftarPrediksi.clear();
    notifyListeners();
  }

  void ubahFilter(String filter) {
    if (!['Semua', 'Petak 1', 'Petak 2'].contains(filter)) {
      return;
    }

    if (_filterPetak == filter) return;

    _filterPetak = filter;
    notifyListeners();
  }

  void buatDataSimulasi() {
    const tanaman = ['Padi', 'Jagung', 'Cabai'];
    final dataSimulasi = <HasilPrediksi>[];

    for (int i = 0; i < 10; i++) {
      final petak = _random.nextBool() ? 'Petak 1' : 'Petak 2';
      final namaTanaman = tanaman[_random.nextInt(tanaman.length)];

      final suhu = 18 + _random.nextDouble() * 17;
      final kelembapanUdara = 40 + _random.nextInt(61);
      final kelembapanTanah = 20 + _random.nextInt(71);

      dataSimulasi.add(
        HasilPrediksi(
          petak: petak,
          tanaman: namaTanaman,
          suhuUdara: double.parse(suhu.toStringAsFixed(1)),
          kelembapanUdara: kelembapanUdara.toDouble(),
          kelembapanTanah: kelembapanTanah.toDouble(),
          namaPetugas: 'Petugas Simulasi',
          waktu: DateTime.now().subtract(Duration(minutes: i)),
        ),
      );
    }

    _daftarPrediksi.insertAll(0, dataSimulasi);
    notifyListeners();
  }
}
