import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final route = GoRouter.of(context);
    final currentLocation = GoRouter.of(context);

    final navLinks = [
      {'href': '/', 'label': 'Home', 'icon': Icons.flash_on},
      {'href': '/dashboard', 'label': 'Dashboard', 'icon': Icons.dashboard},
      {'href': '/billing-sim', 'label': 'Billing Sim', 'icon': Icons.receipt},
      {'href': '/architecture', 'label': 'Architecture', 'icon': Icons.memory},
    ];

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.1),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        border: Border.all(color: Colors.white24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF00BCD4), Color(0xFF1B4F8A)]),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.flash_on, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              const Text(
                'VoltIQ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          const Spacer(),
          ...navLinks.map((link) {
            final isActive = currentLocation == link['href'];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                onPressed: () => route.go(link['href'] as String),
                style: TextButton.styleFrom(
                  backgroundColor: isActive ? const Color(0xFF1B4F8A) : Colors.transparent,
                  foregroundColor: isActive ? Colors.white : Colors.white70,
                ),
                child: Row(
                  children: [
                    Icon(link['icon'] as IconData, size: 16),
                    const SizedBox(width: 4),
                    Text(link['label'] as String),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}