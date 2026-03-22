import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/data/providers/colony_provider.dart';
import 'package:volt_ai_q/data/providers/live_kw_provider.dart';

class ColonyStats extends ConsumerWidget {
  const ColonyStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colonyAsync = ref.watch(colonyDataProvider);
    final liveKW = ref.watch(liveKWProvider);

    return colonyAsync.when(
      data: (colonyData) {
        final stats = [
          _Stat(
            icon: Icons.flash_on,
            label: 'Colony Load',
            value: '${liveKW.toStringAsFixed(1)} kW',
            color: Colors.cyan,
          ),
          _Stat(
            icon: Icons.home,
            label: 'Active Homes',
            value: '${colonyData.totalHomes}',
            color: Colors.blue,
          ),
          _Stat(
            icon: Icons.trending_down,
            label: 'Savings Today',
            value: '₹${(colonyData.totalSaving / 30).round().toStringAsFixed(0)}',
            color: Colors.green,
          ),
          _Stat(
            icon: Icons.eco,
            label: 'CO₂ Saved',
            value: '${(liveKW * 0.082).toStringAsFixed(1)} kg',
            color: Colors.green.shade700,
          ),
        ];

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: stats.map((stat) => _StatCard(stat: stat)).toList(),
        );
      },
      error: (_, _) => const SizedBox.shrink(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _Stat {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  _Stat({required this.icon, required this.label, required this.value, required this.color});
}

class _StatCard extends StatelessWidget {
  final _Stat stat;

  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: stat.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(stat.icon, size: 20, color: stat.color),
          ),
          const SizedBox(height: 8),
          Text(
            stat.value,
            style: TextStyle(color: stat.color, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(stat.label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}
