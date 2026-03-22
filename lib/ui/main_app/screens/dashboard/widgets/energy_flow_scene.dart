import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'package:volt_ai_q/data/providers/appliance_provider.dart';

class EnergyFlowScene extends ConsumerStatefulWidget {
  const EnergyFlowScene({super.key});

  @override
  ConsumerState<EnergyFlowScene> createState() => _EnergyFlowSceneState();
}

class _EnergyFlowSceneState extends ConsumerState<EnergyFlowScene> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appliances = ref.watch(applianceProvider);
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F1C),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: CustomPaint(
          painter: _EnergyFlowPainter(
            appliances: appliances,
            animationValue: _controller.value,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _EnergyFlowPainter extends CustomPainter {
  final List<dynamic> appliances;
  final double animationValue;

  _EnergyFlowPainter({required this.appliances, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) * 0.3;

    // Background Glow
    final bgGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF1B4F8A).withOpacity(0.15),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.5));
    canvas.drawCircle(center, radius * 1.5, bgGlow);

    // Draw meter (central hub)
    final hubPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1B4F8A), Color(0xFF0D2A4D)],
      ).createShader(Rect.fromCircle(center: center, radius: 40));
    
    canvas.drawCircle(center, 40, hubPaint);
    
    // Hub Border
    final hubBorderPaint = Paint()
      ..color = const Color(0xFF00BCD4).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, 40, hubBorderPaint);

    // Meter Icon/Text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '⚡\nVOLT',
        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, height: 1.2),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2));

    if (appliances.isEmpty) return;

    // Draw appliances around
    final angleStep = 2 * pi / appliances.length;
    for (int i = 0; i < appliances.length; i++) {
      final app = appliances[i];
      final angle = i * angleStep - (pi / 2); // Start from top
      final pos = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      // Connection line (Glow effect)
      final linePaint = Paint()
        ..color = app.isOn ? const Color(0xFF00BCD4).withOpacity(0.3) : Colors.white10
        ..strokeWidth = app.isOn ? 3 : 1
        ..style = PaintingStyle.stroke;
      
      // Draw path with curve
      canvas.drawLine(
        Offset.lerp(center, pos, 0.15)!, 
        Offset.lerp(center, pos, 0.85)!, 
        linePaint
      );

      // Flowing particles (if on)
      if (app.isOn) {
        final particleCount = 3;
        for (int p = 0; p < particleCount; p++) {
          final progress = (animationValue + (i * 0.2) + (p * 1/particleCount)) % 1.0;
          final particlePos = Offset.lerp(center, pos, progress)!;
          
          final pPaint = Paint()
            ..color = const Color(0xFF00BCD4)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3);
          canvas.drawCircle(particlePos, 4, pPaint);
          canvas.drawCircle(particlePos, 2, Paint()..color = Colors.white);
        }
      }

      // Appliance Node
      final nodeColor = app.isOn ? const Color(0xFF00BCD4) : Colors.grey.shade800;
      
      // Outer Glow for node
      if (app.isOn) {
        canvas.drawCircle(
          pos, 20, 
          Paint()..color = nodeColor.withOpacity(0.2)..maskFilter = MaskFilter.blur(BlurStyle.normal, 8)
        );
      }

      final nodePaint = Paint()
        ..color = nodeColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, 15, nodePaint);
      
      // Node Icon (simulated)
      final iconPainter = TextPainter(
        text: TextSpan(
          text: _getIconForApp(app.name),
          style: const TextStyle(fontSize: 14),
        ),
        textDirection: TextDirection.ltr,
      );
      iconPainter.layout();
      iconPainter.paint(canvas, Offset(pos.dx - iconPainter.width / 2, pos.dy - iconPainter.height / 2));

      // Name label
      final namePainter = TextPainter(
        text: TextSpan(
          text: app.name, 
          style: TextStyle(
            color: app.isOn ? Colors.white : Colors.white38, 
            fontSize: 11,
            fontWeight: app.isOn ? FontWeight.bold : FontWeight.normal,
          )
        ),
        textDirection: TextDirection.ltr,
      );
      namePainter.layout();
      namePainter.paint(canvas, Offset(pos.dx - namePainter.width / 2, pos.dy + 22));
    }
  }

  String _getIconForApp(String name) {
    name = name.toLowerCase();
    if (name.contains('ac')) return '❄️';
    if (name.contains('light')) return '💡';
    if (name.contains('fridge')) return '🧊';
    if (name.contains('tv')) return '📺';
    if (name.contains('wash')) return '🧺';
    return '🔌';
  }

  @override
  bool shouldRepaint(covariant _EnergyFlowPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || oldDelegate.appliances != appliances;
  }
}
