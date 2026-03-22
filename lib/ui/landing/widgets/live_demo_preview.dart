import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/data/providers/live_kw_provider.dart';
import 'package:volt_ai_q/data/providers/tariff_provider.dart';
enum TariffMode{peak, mid, sasta}
class LiveDemoPreview extends ConsumerWidget {
  const LiveDemoPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kw = ref.watch(liveKWProvider);
    final tariff = ref.watch(tariffModeProvider);

    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Colony Live',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: tariff == TariffMode.sasta
                        ? Colors.green
                        : tariff == TariffMode.mid
                            ? Colors.orange
                            : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tariff.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '${kw.toStringAsFixed(1)} kW',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Total Load',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      (520 - kw / 3).toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '#1 Rank',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                FlatPreview(rank: 1, score: 98),
                FlatPreview(rank: 2, score: 95),
                FlatPreview(rank: 3, score: 92),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FlatPreview extends StatelessWidget {
  final int rank;
  final int score;

  const FlatPreview({super.key, required this.rank, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Flat $rank',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Text(
          '$score%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
