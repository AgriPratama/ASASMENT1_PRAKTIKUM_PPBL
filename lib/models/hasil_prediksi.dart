class HasilPrediksi {
  final String petak;
  final String tanaman;
  final double suhuUdara;
  final double kelembapanUdara;
  final double kelembapanTanah;
  final String namaPetugas;
  final DateTime waktu;

  HasilPrediksi({
    required this.petak,
    required this.tanaman,
    required this.suhuUdara,
    required this.kelembapanUdara,
    required this.kelembapanTanah,
    required this.namaPetugas,
    DateTime? waktu,
  }) : waktu = waktu ?? DateTime.now();

  String get status {
    if (kelembapanTanah < 40) {
      return 'Kering';
    } else if (kelembapanTanah <= 70) {
      return 'Optimal';
    } else {
      return 'Terlalu Lembap';
    }
  }

  String get rekomendasi {
    if (status == 'Kering') {
      return 'Segera lakukan penyiraman atau irigasi';
    } else if (status == 'Optimal') {
      return 'Pertahankan pola perawatan saat ini';
    } else {
      return 'Kurangi penyiraman dan periksa drainase';
    }
  }

  String get catatanPerawatan {
    switch (tanaman) {
      case 'Padi':
        return 'Jaga genangan air 2–5 cm pada fase '
            'vegetatif dan keringkan lahan menjelang panen.';
      case 'Jagung':
        return 'Siram saat tanah mulai kering dan hindari '
            'genangan di sekitar perakaran.';
      case 'Cabai':
        return 'Gunakan mulsa untuk menjaga kelembapan tanah '
            'dan siram pada pagi atau sore hari.';
      default:
        return '-';
    }
  }
}
