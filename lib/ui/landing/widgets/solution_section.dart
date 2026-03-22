import 'package:flutter/material.dart';

class SolutionSection extends StatelessWidget {
  const SolutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final brains = [
      BrainData(
        icon: Icons.memory,
        title: 'ML Engine',
        subtitle: 'Predict & Classify',
        description: 'Forecasts your appliance usage patterns using XGBoost. Predicts next-hour demand so the optimizer can plan ahead.',
        color: Colors.purple,
        lightBg: Colors.purple.shade50,
      ),
      BrainData(
        icon: Icons.calculate,
        title: 'MILP Optimizer',
        subtitle: 'Schedule & Save',
        description: 'Mixed-Integer Linear Programming finds the cheapest schedule for your appliances while respecting your comfort preferences.',
        color: Colors.blue,
        lightBg: Colors.blue.shade50,
      ),
      BrainData(
        icon: Icons.notifications_active,
        title: 'Action Engine',
        subtitle: 'Alert & Automate',
        description: 'Real-time tariff change detection triggers instant push notifications and automated appliance scheduling.',
        color: Colors.amber,
        lightBg: Colors.amber.shade50,
      ),
      BrainData(
        icon: Icons.chat,
        title: 'Chat Agent',
        subtitle: 'Ask & Understand',
        description: 'Hindi/English AI chatbot answers billing questions, explains usage patterns, and suggests personalized tips.',
        color: Colors.green,
        lightBg: Colors.green.shade50,
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          const Text(
            'THE SOLUTION',
            style: TextStyle(
              color: Color(0xFF00BCD4),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Four brains. One mission.',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF0A0E1A)),
          ),
          const SizedBox(height: 8),
          const Text(
            "VoltIQ's 4-brain architecture turns raw meter data into real savings.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.2,
                  children: brains.map((b) => _BrainCard(data: b)).toList(),
                );
              } else {
                return Column(
                  children: brains.map((b) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _BrainCard(data: b),
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

class BrainData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Color color;
  final Color lightBg;

  BrainData({required this.icon, required this.title, required this.subtitle, required this.description, required this.color, required this.lightBg});
}

class _BrainCard extends StatelessWidget {
  final BrainData data;

  const _BrainCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: data.lightBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: data.color, size: 28),
          ),
          const SizedBox(height: 16),
          Text(data.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0A0E1A))),
          Text(data.subtitle, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: data.color)),
          const SizedBox(height: 8),
          Text(data.description, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}