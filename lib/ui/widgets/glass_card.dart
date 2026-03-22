import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final String? className;
  final bool dark;
  final bool hover;
  final String glow;
  final int delay;

  const GlassCard({
    super.key,
    required this.child,
    this.className,
    this.dark = false,
    this.hover = true,
    this.glow = 'none',
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    Color baseColor;
    Color borderColor;
    if (dark) {
      baseColor = Colors.white.withValues(alpha:0.08);
      borderColor = Colors.white.withValues(alpha:0.12);
    } else {
      baseColor = Colors.white.withValues(alpha:0.05);
      borderColor = Colors.white.withValues(alpha:0.08);
    }

    Color? glowColor;
    switch (glow) {
      case 'cyan':
        glowColor = const Color(0xFF00BCD4);
        break;
      case 'blue':
        glowColor = const Color(0xFF1B4F8A);
        break;
      case 'green':
        glowColor = const Color(0xFF2E7D32);
        break;
      default:
        glowColor = null;
    }

    Widget card = Container(
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: hover && glowColor != null
            ? [
                BoxShadow(
                  color: glowColor.withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (hover) {
      card = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: card,
      );
    }

    if (delay > 0) {
      card = card.animate().fadeIn(duration: 500.ms, delay: delay.ms).slideY(begin: 0.2);
    }

    return card;
  }
}

