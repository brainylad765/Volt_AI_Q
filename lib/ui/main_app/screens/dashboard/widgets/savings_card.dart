import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/data/providers/colony_provider.dart';

class SavingsCard extends ConsumerWidget {
  const SavingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colonyAsync = ref.watch(colonyDataProvider);

    return colonyAsync.when(
      data: (colonyData) {
        final totalSaving = colonyData.totalSaving;
        final avgPerFlat = (totalSaving / colonyData.totalHomes).round();
        final bestScore = colonyData.flats.isNotEmpty ? colonyData.flats.first.energyScore : 0;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.withOpacity(0.1), Colors.green.shade50.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.currency_rupee, color: Colors.green),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Colony Savings',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '₹${totalSaving.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const Text('This month', style: TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.trending_up, size: 14, color: Colors.green),
                  const SizedBox(width: 4),
                  const Text('+12.3% vs last month', style: TextStyle(color: Colors.green, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white10),
              const SizedBox(height: 16),
              const Text('Quick Stats', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 12),
              _QuickStat(
                icon: Icons.calendar_today,
                label: 'Avg per flat',
                value: '₹$avgPerFlat',
                color: Colors.blue,
              ),
              const SizedBox(height: 12),
              _QuickStat(
                icon: Icons.safety_check,
                label: 'Best scorer',
                value: '⚡$bestScore',
                color: Colors.amber,
              ),
              const SizedBox(height: 12),
              _QuickStat(
                icon: Icons.trending_up,
                label: 'Peak reduced by',
                value: '18.4%',
                color: Colors.green,
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

class _QuickStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _QuickStat({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10)),
              Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
