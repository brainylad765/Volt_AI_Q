import 'package:flutter/material.dart';
import 'package:volt_ai_q/data/models/appliance.dart';

class ApplianceCard extends StatelessWidget {
  final Appliance appliance;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const ApplianceCard({
    super.key,
    required this.appliance,
    required this.isExpanded,
    required this.onTap,
    required this.onToggle,
  });

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'AirVent': return Icons.ac_unit;
      case 'Droplets': return Icons.water_drop;
      case 'WashingMachine': return Icons.local_laundry_service;
      case 'Tv': return Icons.tv;
      case 'Lightbulb': return Icons.lightbulb;
      case 'Refrigerator': return Icons.kitchen;
      case 'Fan': return Icons.mode_fan_off_rounded;
      default: return Icons.devices;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOn = appliance.isOn;
    final color = isOn ? Colors.cyan : Colors.white54;
    final bgColor = isOn ? Colors.cyan.withOpacity(0.1) : Colors.white10;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isOn ? Colors.cyan.withOpacity(0.2) : Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isOn ? Colors.cyan.withOpacity(0.2) : Colors.white12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_getIcon(appliance.iconName), size: 24, color: color),
                ),
                const Spacer(),
                Switch(
                  value: isOn,
                  onChanged: (_) => onToggle(),
                  activeThumbColor: Colors.cyan,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(appliance.name, style: TextStyle(color: isOn ? Colors.white : Colors.white54, fontWeight: FontWeight.bold)),
            Text(appliance.category, style: const TextStyle(color: Colors.white54, fontSize: 10)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('${appliance.kw} kW', style: TextStyle(color: isOn ? Colors.cyan : Colors.white54, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text('₹${appliance.monthlyCost}/mo', style: const TextStyle(color: Colors.blue)),
              ],
            ),
            if (appliance.smartEnabled) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('⚡ VoltIQ Smart', style: TextStyle(fontSize: 8, color: Colors.cyan)),
              ),
            ],
            if (isExpanded) ...[
              const SizedBox(height: 12),
              const Divider(),
              _DetailRow(label: 'Daily energy', value: '${(appliance.kw * appliance.dailyHours).toStringAsFixed(2)} kWh'),
              _DetailRow(label: 'Monthly energy', value: '${(appliance.kw * appliance.dailyHours * 30).toStringAsFixed(1)} kWh'),
              if (!appliance.smartEnabled)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: const [
                      Icon(Icons.warning_amber, size: 12, color: Colors.amber),
                      SizedBox(width: 4),
                      Text('Enable smart scheduling to save more', style: TextStyle(fontSize: 10, color: Colors.amber)),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
