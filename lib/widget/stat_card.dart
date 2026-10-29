import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String judul;
  final int nilai;
  final IconData ikon;
  final Color warna;

  const StatCard({
    super.key,
    required this.judul,
    required this.nilai,
    required this.ikon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ikon, color: warna, size: 28),
            const SizedBox(height: 8),
            Text('$nilai', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              judul,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
