import '../models/hasil_prediksi.dart';

class PrediksiState {
  final List<HasilPrediksi> daftarPrediksi;
  final String filterPetak;

  const PrediksiState({
    this.daftarPrediksi = const [],
    this.filterPetak = 'Semua',
  });

  List<HasilPrediksi> get semuaPrediksi => List.unmodifiable(daftarPrediksi);

  List<HasilPrediksi> get daftarTerfilter {
    if (filterPetak == 'Semua') {
      return semuaPrediksi;
    }

    return daftarPrediksi.where((data) => data.petak == filterPetak).toList();
  }

  int get total => daftarPrediksi.length;

  int get jumlahOptimal => jumlahStatus('Optimal');

  int get jumlahPerluTindakan =>
      jumlahStatus('Kering') + jumlahStatus('Terlalu Lembap');

  int jumlahStatus(String status) {
    return daftarPrediksi.where((data) => data.status == status).length;
  }

  PrediksiState copyWith({
    List<HasilPrediksi>? daftarPrediksi,
    String? filterPetak,
  }) {
    return PrediksiState(
      daftarPrediksi: daftarPrediksi ?? this.daftarPrediksi,
      filterPetak: filterPetak ?? this.filterPetak,
    );
  }
}
