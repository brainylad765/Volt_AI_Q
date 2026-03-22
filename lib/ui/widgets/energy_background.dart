import 'package:flutter/material.dart';
import 'dart:math';

class EnergyBackground extends StatefulWidget {
  final Widget? child;
  const EnergyBackground({super.key, this.child});

  @override
  State<EnergyBackground> createState() => _EnergyBackgroundState();
}

class _EnergyBackgroundState extends State<EnergyBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: const Color(0xFF0A0E1A),
          ),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _EnergyGridPainter(progress: _controller.value),
              );
            },
          ),
        ),
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class _EnergyGridPainter extends CustomPainter {
  final double progress;

  _EnergyGridPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00BCD4).withOpacity(0.05)
      ..strokeWidth = 1.0;

    const spacing = 40.0;
    final offsetX = (progress * spacing) % spacing;
    final offsetY = (progress * spacing) % spacing;

    // Vertical lines
    for (double x = offsetX; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = offsetY; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw some "energy pulses"
    final pulsePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00BCD4).withOpacity(0.1),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, 200, 200));

    final random = Random(42);
    for (int i = 0; i < 5; i++) {
      final x = random.nextDouble() * size.width;
      final y = (random.nextDouble() * size.height + progress * 200) % size.height;
      
      canvas.save();
      canvas.translate(x, y);
      canvas.drawCircle(Offset.zero, 100, pulsePaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _EnergyGridPainter oldDelegate) => true;
}
