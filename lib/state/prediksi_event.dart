import '../models/hasil_prediksi.dart';

abstract class PrediksiEvent {}

class TambahPrediksi extends PrediksiEvent {
  final HasilPrediksi data;

  TambahPrediksi(this.data);
}

class HapusPrediksi extends PrediksiEvent {
  final HasilPrediksi data;

  HapusPrediksi(this.data);
}

class HapusSemuaPrediksi extends PrediksiEvent {}

class UbahFilterPetak extends PrediksiEvent {
  final String filter;

  UbahFilterPetak(this.filter);
}

class MuatDataSimulasi extends PrediksiEvent {}

class MuatDataAwal extends PrediksiEvent {}
