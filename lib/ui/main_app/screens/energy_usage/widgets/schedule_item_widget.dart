import 'package:flutter/material.dart';
import 'package:volt_ai_q/data/models/schedule_item.dart';

class ScheduleItemWidget extends StatelessWidget {
  final ScheduleItem item;

  const ScheduleItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusBg;
    switch (item.status) {
      case 'completed':
        statusColor = Colors.white54;
        statusBg = Colors.white10;
        break;
      case 'active':
        statusColor = Colors.green;
        statusBg = Colors.green.withOpacity(0.1);
        break;
      case 'scheduled':
        statusColor = Colors.blue;
        statusBg = Colors.blue.withOpacity(0.1);
        break;
      case 'optimized':
        statusColor = Colors.cyan;
        statusBg = Colors.cyan.withOpacity(0.1);
        break;
      default:
        statusColor = Colors.white70;
        statusBg = Colors.white10;
    }

    Color tariffColor;
    switch (item.tariff) {
      case 'sasta':
        tariffColor = Colors.green;
        break;
      case 'mid':
        tariffColor = Colors.amber;
        break;
      case 'peak':
        tariffColor = Colors.red;
        break;
      default:
        tariffColor = Colors.white70;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.white54),
                const SizedBox(width: 4),
                Text(item.time, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.appliance, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                Text(item.duration, style: const TextStyle(color: Colors.white54, fontSize: 10)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(item.status, style: TextStyle(color: statusColor, fontSize: 10)),
          ),
          const SizedBox(width: 12),
          Text(item.tariff.toUpperCase(), style: TextStyle(color: tariffColor, fontSize: 10, fontWeight: FontWeight.bold)),
          if (item.saved > 0) ...[
            const SizedBox(width: 12),
            Text('+₹${item.saved}', style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ],
      ),
    );
  }
}
