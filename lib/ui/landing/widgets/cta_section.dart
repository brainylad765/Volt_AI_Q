import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0E1A), Color(0xFF0D1326)],
        ),
      ),
      child: Column(
        children: [
          // Particle effects (simulated with a simple container)
          Stack(
            children: [
              Positioned.fill(
                child: Container(
                  child: const Center(
                    child: SizedBox.shrink(),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(48),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00BCD4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.2)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.flash_on, size: 16, color: Color(0xFF00BCD4)),
                          SizedBox(width: 8),
                          Text('Ready to save?', style: TextStyle(color: Color(0xFF00BCD4))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Your meter is smart.\nMake your bill smarter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Join 200+ homes already saving with VoltIQ. No hardware needed — just your existing smart meter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => context.go('/billing-sim'),
                          icon: const Icon(Icons.flash_on, size: 18),
                          label: const Text('Start Saving Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BCD4),
                            foregroundColor: const Color(0xFF0A0E1A),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () => context.go('/architecture'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text('How it works →'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ).animate().fadeIn().slideY(begin: 0.2),
    );
  }
}