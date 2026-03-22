import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StatItem {
  final String label;
  final String value;
  final bool highlight;

  const StatItem({required this.label, required this.value, this.highlight = false});
}

class OverviewCard extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  final List<StatItem> stats;

  const OverviewCard({
    super.key,
    required this.title,
    required this.route,
    required this.icon,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 20, color: Colors.cyan),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
              ],
            ),
            const SizedBox(height: 16),
            ...stats.map((stat) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(stat.label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  Text(
                    stat.value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: stat.highlight ? Colors.cyan : Colors.white,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
