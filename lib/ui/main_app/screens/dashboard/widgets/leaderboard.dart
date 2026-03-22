import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/data/providers/colony_provider.dart';

class Leaderboard extends ConsumerWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colonyAsync = ref.watch(colonyDataProvider);

    return colonyAsync.when(
      data: (colonyData) {
        final flats = colonyData.flats;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Flat Leaderboard',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const Text('Top energy savers this month', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.flash_on, size: 12, color: Colors.white54),
                      SizedBox(width: 4),
                      Text('Updates live', style: TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Header row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 40, child: Text('Rank', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white54))),
                    Expanded(flex: 2, child: Text('Flat', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white54))),
                    Expanded(child: Text('Savings', textAlign: TextAlign.right, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white54))),
                    Expanded(child: Text('Score', textAlign: TextAlign.right, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white54))),
                    Expanded(child: Text('kW', textAlign: TextAlign.right, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white54))),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // List of flats
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: flats.length,
                separatorBuilder: (_, _) => const Divider(color: Colors.white10),
                itemBuilder: (context, index) {
                  final flat = flats[index];
                  final rankIcon = index == 0 ? Icons.emoji_events : (index == 1 ? Icons.money : (index == 2 ? Icons.emoji_events_outlined : null));
                  final rankColor = index == 0 ? Colors.amber : (index == 1 ? Colors.grey : (index == 2 ? Colors.brown : Colors.white54));
                  final rowBg = index < 3 ? Colors.white.withValues(alpha: 0.03) : null;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: rowBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: rankIcon != null
                              ? Icon(rankIcon, size: 20, color: rankColor)
                              : Text('${flat.rank}', style: TextStyle(color: rankColor, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(flat.flat, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          child: Text(
                            '₹${flat.savings.toStringAsFixed(0)}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '⚡${flat.energyScore}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: flat.energyScore >= 90 ? Colors.green : (flat.energyScore >= 75 ? Colors.amber : Colors.red),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            flat.kw.toStringAsFixed(2),
                            textAlign: TextAlign.right,
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      error: (_, _) => const SizedBox.shrink(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
