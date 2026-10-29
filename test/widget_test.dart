import 'package:flutter_test/flutter_test.dart';
import 'package:agriclima_ltsm_707012400064/main.dart';

void main() {
  testWidgets('AgriClima app dapat dibuka', (tester) async {
    await tester.pumpWidget(const AgriClimaApp());

    expect(find.text('Beranda'), findsWidgets);
    expect(find.text('Prediksi'), findsWidgets);
    expect(find.text('Statistik'), findsWidgets);
    expect(find.text('Pengaturan'), findsWidgets);
  });
}
