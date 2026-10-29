import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../state/prediksi_model.dart';

class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrediksiModel>(
      builder: (context, model, child) {
        final kering = model.jumlahStatus('Kering');
        final optimal = model.jumlahStatus('Optimal');
        final lembap = model.jumlahStatus('Terlalu Lembap');

        final nilaiTertinggi = [
          kering,
          optimal,
          lembap,
        ].reduce((a, b) => a > b ? a : b);

        final batasAtas = nilaiTertinggi == 0
            ? 5.0
            : (nilaiTertinggi + 1).toDouble();

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah Prediksi per Status Mikroklimat',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 280,
                      child: BarChart(
                        BarChartData(
                          maxY: batasAtas,
                          minY: 0,
                          alignment: BarChartAlignment.spaceAround,
                          gridData: const FlGridData(show: true),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 32,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 48,
                                getTitlesWidget: (value, meta) {
                                  String label;

                                  switch (value.toInt()) {
                                    case 0:
                                      label = 'Kering';
                                      break;
                                    case 1:
                                      label = 'Optimal';
                                      break;
                                    case 2:
                                      label = 'Terlalu\\nLembap';
                                      break;
                                    default:
                                      return const SizedBox.shrink();
                                  }

                                  return SideTitleWidget(
                                    meta: meta,
                                    child: Text(
                                      label,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(
                                  toY: kering.toDouble(),
                                  width: 32,
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(
                                  toY: optimal.toDouble(),
                                  width: 32,
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(
                                  toY: lembap.toDouble(),
                                  width: 32,
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
