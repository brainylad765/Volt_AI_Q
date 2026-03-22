import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'hero_scene.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0E1A), Color(0xFF0A0F1C)],
        ),
      ),
      child: Stack(
        children: [
          // Background 3D globe animation
          const Positioned.fill(
            child: HeroScene(),
          ),
          
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.cyan],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'INSTINCT 4.0',
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 48,
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.cyan, Colors.transparent],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "India's Smart\nEnergy Brain",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '3 crore smart meters. Zero consumer intelligence.\nVoltIQ changes that.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.go('/app'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 8,
                          shadowColor: Colors.cyan.withOpacity(0.5),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.flash_on, size: 20),
                            SizedBox(width: 8),
                            Text('Start Saving', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () => context.go('/app'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white30),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Overview Dashboard →'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Scroll indicator
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 10),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutSine,
                builder: (_, value, _) {
                  return Transform.translate(
                    offset: Offset(0, value),
                    child: const Icon(Icons.keyboard_arrow_down, color: Colors.cyan, size: 24),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
