import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  final String name;

  const WelcomeHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back, $name!',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'A concise snapshot of your home\'s energy intelligence.',
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
      ],
    );
  }
}
