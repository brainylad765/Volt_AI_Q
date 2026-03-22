import 'package:flutter/material.dart';

class ProblemSection extends StatelessWidget {
  const ProblemSection({super.key});

  @override
  Widget build(BuildContext context) {
    final problems = [
      ProblemData(
        icon: Icons.speed,
        stat: '3 Crore',
        label: 'Smart Meters Installed',
        description: 'India has deployed millions of smart meters, but the data flows only to utilities.',
      ),
      ProblemData(
        icon: Icons.warning_amber,
        stat: 'Zero',
        label: 'Consumer Intelligence',
        description: 'Homeowners get no insights, no optimization, no savings from their own meter data.',
      ),
      ProblemData(
        icon: Icons.currency_rupee,
        stat: '₹2,400 Cr',
        label: 'Wasted Annually',
        description: 'Indian households overpay due to peak-hour usage and zero tariff awareness.',
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'THE PROBLEM',
            style: TextStyle(
              color: Color(0xFFC62828),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Smart meters, dumb experience',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF0A0E1A)),
          ),
          const SizedBox(height: 8),
          const Text(
            'India invested ₹22,000 crore in smart metering. Consumers got nothing in return.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  children: problems.map((p) => Expanded(child: _ProblemCard(data: p))).toList(),
                );
              } else {
                return Column(
                  children: problems.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _ProblemCard(data: p),
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

class ProblemData {
  final IconData icon;
  final String stat;
  final String label;
  final String description;

  ProblemData({required this.icon, required this.stat, required this.label, required this.description});
}

class _ProblemCard extends StatelessWidget {
  final ProblemData data;

  const _ProblemCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: const Color(0xFFC62828), size: 28),
          ),
          const SizedBox(height: 16),
          Text(data.stat, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0A0E1A))),
          const SizedBox(height: 4),
          Text(data.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC62828))),
          const SizedBox(height: 8),
          Text(data.description, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

