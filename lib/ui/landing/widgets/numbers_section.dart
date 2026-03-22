import 'package:flutter/material.dart';

class NumbersSection extends StatelessWidget {
  const NumbersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      NumberStat(
        icon: Icons.speed,
        value: 30000000,
        displayValue: '3 Cr+',
        suffix: '',
        label: 'Smart Meters',
        description: 'Already installed across India',
        color: Colors.cyan,
      ),
      NumberStat(
        icon: Icons.percent,
        value: 23,
        displayValue: '23',
        suffix: '%',
        label: 'Average Savings',
        description: 'On monthly electricity bills',
        color: Colors.green,
      ),
      NumberStat(
        icon: Icons.flash_on,
        value: 6,
        displayValue: '6',
        suffix: ' GW',
        label: 'Peak Shaving',
        description: 'At 1 crore home scale',
        color: Colors.amber,
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          const Text(
            'BY THE NUMBERS',
            style: TextStyle(
              color: Color(0xFF1B4F8A),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Impact at scale',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF0A0E1A)),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  children: stats.map((s) => Expanded(child: _NumberCard(stat: s))).toList(),
                );
              } else {
                return Column(
                  children: stats.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _NumberCard(stat: s),
                  )).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class NumberStat {
  final IconData icon;
  final double value; // for animation
  final String displayValue;
  final String suffix;
  final String label;
  final String description;
  final Color color;

  NumberStat({
    required this.icon,
    required this.value,
    required this.displayValue,
    required this.suffix,
    required this.label,
    required this.description,
    required this.color,
  });
}

class _NumberCard extends StatelessWidget {
  final NumberStat stat;

  const _NumberCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [stat.color.withOpacity(0.05), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(stat.icon, color: stat.color, size: 32),
          ),
          const SizedBox(height: 24),
          if (stat.value < 100)
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: stat.value),
              duration: const Duration(seconds: 2),
              builder: (_, value, _) {
                return Text(
                  '${value.toInt()}${stat.suffix}',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: stat.color),
                );
              },
            )
          else
            Text(stat.displayValue, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: stat.color)),
          const SizedBox(height: 8),
          Text(stat.label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0A0E1A))),
          const SizedBox(height: 8),
          Text(stat.description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}