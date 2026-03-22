import 'package:flutter/material.dart';
// Assuming AnimatedCounter is defined in a separate file, e.g., 'animated_counter.dart'
// If not, you'll need to create it or adjust accordingly.
import 'package:volt_ai_q/ui/widgets/animated_counter.dart'; // adjust import path

class ImpactNumbers extends StatelessWidget {
  const ImpactNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Monthly Savings
        AnimatedCounter(
          end: 2500,          // numeric value, not a string
          prefix: '₹',
          duration: Duration(seconds: 2),
        ),
        const SizedBox(height: 8),
        const Text(
          'Monthly Savings',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 24),
        // Trees Saved
        AnimatedCounter(
          end: 4200,
          suffix: ' trees',
          duration: Duration(seconds: 2),
        ),
        const SizedBox(height: 8),
        const Text(
          'Trees Saved',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}