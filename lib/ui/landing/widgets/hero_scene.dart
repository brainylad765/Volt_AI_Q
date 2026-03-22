import 'package:flutter/material.dart';
import 'dart:math';

class HeroScene extends StatefulWidget {
  const HeroScene({super.key});

  @override
  State<HeroScene> createState() => _HeroSceneState();
}

class _HeroSceneState extends State<HeroScene> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> particles = List.generate(50, (index) => Particle());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: GlobePainter(
            rotation: _controller.value * 2 * pi,
            particles: particles,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  final double theta = Random().nextDouble() * 2 * pi;
  final double phi = acos(2 * Random().nextDouble() - 1);
  final double radiusMultiplier = 0.8 + Random().nextDouble() * 0.4;
  final double speed = 0.2 + Random().nextDouble() * 0.8;
}

class GlobePainter extends CustomPainter {
  final double rotation;
  final List<Particle> particles;

  GlobePainter({required this.rotation, required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) * 0.35;

    // Draw background glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00BCD4).withOpacity(0.1),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 2));
    canvas.drawCircle(center, radius * 2, glowPaint);

    // Draw main sphere (gradient)
    final spherePaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFF1B4F8A), Color(0xFF0A0E1A)],
        stops: [0.3, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, spherePaint);

    // Draw wireframe
    final wirePaint = Paint()
      ..color = const Color(0xFF00BCD4).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Latitude lines
    for (double lat = -80; lat <= 80; lat += 20) {
      final r = radius * cos(lat * pi / 180);
      final yOffset = radius * sin(lat * pi / 180);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(center.dx, center.dy + yOffset),
          width: r * 2,
          height: r * 0.5, // Perspective
        ),
        wirePaint,
      );
    }

    // Longitude lines
    for (int i = 0; i < 8; i++) {
      final angle = (i * pi / 4) + rotation;
      final path = Path();
      for (double lat = -90; lat <= 90; lat += 5) {
        final radLat = lat * pi / 180;
        final r = radius * cos(radLat);
        final x = center.dx + r * cos(angle);
        final y = center.dy + radius * sin(radLat);
        if (lat == -90) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, wirePaint);
    }

    // Orbiting rings
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Outer Glow Ring
    ringPaint.color = const Color(0xFF00BCD4).withOpacity(0.3);
    canvas.drawCircle(center, radius * 1.2, ringPaint);

    // Dynamic Rings
    for (int i = 0; i < 3; i++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotation * (0.3 + i * 0.2));
      canvas.rotateX(pi / 3 + i * 0.2);
      
      ringPaint.color = const Color(0xFF00BCD4).withOpacity(0.2 - i * 0.05);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: radius * (2.2 + i * 0.4),
          height: radius * (1.8 + i * 0.2),
        ),
        ringPaint,
      );
      canvas.restore();
    }

    // Particle dots
    final particlePaint = Paint()..color = const Color(0xFF00BCD4).withOpacity(0.6);
    for (var p in particles) {
      final currentRotation = rotation * p.speed;
      final x = center.dx + radius * p.radiusMultiplier * sin(p.phi) * cos(p.theta + currentRotation);
      final y = center.dy + radius * p.radiusMultiplier * cos(p.phi);
      
      // Depth effect: scale and opacity based on Z (simulated)
      final z = sin(p.phi) * sin(p.theta + currentRotation);
      if (z > -0.5) { // Only draw if "in front" or slightly behind
        final scale = (z + 1.5) / 2;
        particlePaint.color = const Color(0xFF00BCD4).withOpacity(0.3 + 0.4 * scale);
        canvas.drawCircle(Offset(x, y), 1.5 * scale, particlePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant GlobePainter oldDelegate) => true;
}

extension on Canvas {
  void rotateX(double angle) {
    final matrix = Matrix4.identity()..rotateX(angle);
    transform(matrix.storage);
  }
}
