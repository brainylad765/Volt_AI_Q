import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/data/providers/tariff_provider.dart';

import '../../../../../data/models/tariff_mode.dart';

class TariffBanner extends ConsumerWidget {
  const TariffBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tariffMode = ref.watch(tariffModeProvider);

    // Config based on mode
    final config = _getConfig(tariffMode);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Container(
        key: ValueKey(tariffMode),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              config.bgColor.withOpacity(0.2),
              config.bgColor.withOpacity(0.1),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: config.borderColor),
        ),
        child: Stack(
          children: [
            // Animated top bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: (_, value, _) {
                  return Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width * value,
                    color: config.barColor,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: config.dotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            config.label,
                            style: TextStyle(
                              color: config.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            config.advice,
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(config.icon, color: config.textColor, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        config.rate,
                        style: TextStyle(
                          color: config.textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _TariffConfig _getConfig(TariffMode mode) {
    switch (mode) {
      case TariffMode.peak:
        return _TariffConfig(
          label: 'PEAK TARIFF',
          rate: '₹8.5 / kWh',
          advice: 'High rates! Avoid heavy appliances.',
          icon: Icons.flash_on,
          bgColor: Colors.red,
          borderColor: Colors.red.withOpacity(0.3),
          dotColor: Colors.red,
          textColor: Colors.red,
          barColor: Colors.red,
        );
      case TariffMode.mid:
        return _TariffConfig(
          label: 'MID TARIFF',
          rate: '₹5.2 / kWh',
          advice: 'Moderate rates. Use wisely.',
          icon: Icons.wb_sunny,
          bgColor: Colors.amber,
          borderColor: Colors.amber.withOpacity(0.3),
          dotColor: Colors.amber,
          textColor: Colors.amber,
          barColor: Colors.amber,
        );
      case TariffMode.sasta:
        return _TariffConfig(
          label: 'SASTA TARIFF',
          rate: '₹3.1 / kWh',
          advice: 'Best time! Run heavy appliances now.',
          icon: Icons.trending_down,
          bgColor: Colors.green,
          borderColor: Colors.green.withOpacity(0.3),
          dotColor: Colors.green,
          textColor: Colors.green,
          barColor: Colors.green,
        );
    }
  }
}

class _TariffConfig {
  final String label;
  final String rate;
  final String advice;
  final IconData icon;
  final Color bgColor;
  final Color borderColor;
  final Color dotColor;
  final Color textColor;
  final Color barColor;

  _TariffConfig({
    required this.label,
    required this.rate,
    required this.advice,
    required this.icon,
    required this.bgColor,
    required this.borderColor,
    required this.dotColor,
    required this.textColor,
    required this.barColor,
  });
}
