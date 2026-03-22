import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/data/providers/alerts_provider.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertsProvider);
    final unreadCount = alerts.where((a) => !a.read).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () => ref.read(alertsProvider.notifier).markAllAsRead(),
              child: Text('Mark all read'),
            ),
        ],
      ),
      body: alerts.isEmpty
          ? const Center(child: Text('No alerts'))
          : ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final alert = alerts[index];
                final config = _getConfig(alert.type);
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: config.bgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(config.icon, color: config.iconColor),
                  ),
                  title: Text(alert.title, style: TextStyle(fontWeight: alert.read ? FontWeight.normal : FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(alert.message),
                      const SizedBox(height: 4),
                      Text(alert.time, style: const TextStyle(fontSize: 10, color: Colors.white54)),
                    ],
                  ),
                  trailing: alert.read
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.check_circle_outline),
                          onPressed: () => ref.read(alertsProvider.notifier).markAsRead(alert.id),
                        ),
                );
              },
            ),
    );
  }

  _AlertConfig _getConfig(String type) {
    switch (type) {
      case 'tariff':
        return _AlertConfig(icon: Icons.warning, iconColor: Colors.red, bgColor: Colors.red.withOpacity(0.1));
      case 'saving':
        return _AlertConfig(icon: Icons.savings, iconColor: Colors.green, bgColor: Colors.green.withOpacity(0.1));
      case 'anomaly':
        return _AlertConfig(icon: Icons.bug_report, iconColor: Colors.amber, bgColor: Colors.amber.withOpacity(0.1));
      default:
        return _AlertConfig(icon: Icons.info, iconColor: Colors.blue, bgColor: Colors.blue.withOpacity(0.1));
    }
  }
}

class _AlertConfig {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  _AlertConfig({required this.icon, required this.iconColor, required this.bgColor});
}