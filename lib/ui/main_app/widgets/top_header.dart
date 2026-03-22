import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volt_ai_q/data/providers/notification_provider.dart';
import 'package:volt_ai_q/data/models/notification.dart';

class TopHeader extends ConsumerStatefulWidget {
  const TopHeader({super.key});

  @override
  ConsumerState<TopHeader> createState() => _TopHeaderState();
}

class _TopHeaderState extends ConsumerState<TopHeader> {
  bool _notifOpen = false;
  bool _profileOpen = false;

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider);
    final unreadCount = notifications.where((n) => !n.read).length;

    return Stack(
      children: [
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF0D1226).withOpacity(0.8),
            border: const Border(bottom: BorderSide(color: Colors.white10)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 24),
              // Page title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getPageTitle(GoRouterState.of(context).uri.path),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text('Welcome back, Avinash', style: TextStyle(fontSize: 12, color: Colors.white54)),
                ],
              ),
              const Spacer(),
              // Notification bell
              GestureDetector(
                onTap: () {
                  setState(() {
                    _notifOpen = !_notifOpen;
                    _profileOpen = false;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      const Center(child: Icon(Icons.notifications, size: 20, color: Colors.white54)),
                      if (unreadCount > 0)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Color(0xFFC62828),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$unreadCount',
                                style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Profile button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _profileOpen = !_profileOpen;
                    _notifOpen = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF1B4F8A), Color(0xFF00BCD4)]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(child: Icon(Icons.person, color: Colors.white, size: 20)),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Avinash', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text('Flat A-301', style: TextStyle(fontSize: 10, color: Colors.white54)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
        // Notification panel
        if (_notifOpen)
          Positioned(
            top: 64,
            right: 16,
            child: _NotificationPanel(
              notifications: notifications,
              onClose: () => setState(() => _notifOpen = false),
              onMarkRead: (id) => ref.read(notificationsProvider.notifier).markAsRead(id),
              onMarkAllRead: () => ref.read(notificationsProvider.notifier).markAllAsRead(),
            ),
          ),
        // Profile dropdown
        if (_profileOpen)
          Positioned(
            top: 64,
            right: 16,
            child: _ProfileDropdown(onClose: () => setState(() => _profileOpen = false)),
          ),
      ],
    );
  }

  String _getPageTitle(String path) {
    switch (path) {
      case '/energy-usage':
        return 'Energy Usage & Daily Schedules';
      case '/appliances':
        return 'Appliances';
      case '/billing':
        return 'Billing & Saving';
      case '/carbon':
        return 'Carbon Footprints';
      case '/dashboard':
        return 'Dashboard Overview';
      case '/billing-sim':
        return 'Billing Simulator';
      case '/architecture':
        return 'Architecture';
      default:
        return 'Dashboard';
    }
  }
}

class _NotificationPanel extends StatelessWidget {
  final List<AppNotification> notifications;
  final VoidCallback onClose;
  final Function(String) onMarkRead;
  final VoidCallback onMarkAllRead;

  const _NotificationPanel({
    required this.notifications,
    required this.onClose,
    required this.onMarkRead,
    required this.onMarkAllRead,
  });

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications.where((n) => !n.read).length;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 384,
        constraints: const BoxConstraints(maxHeight: 500),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white10)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications, size: 20, color: Color(0xFF1B4F8A)),
                  const SizedBox(width: 8),
                  const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  const Spacer(),
                  if (unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC62828).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('$unreadCount new', style: const TextStyle(fontSize: 12, color: Color(0xFFC62828))),
                    ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onClose,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.close, size: 16, color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ),
            // List
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final n = notifications[index];
                  return _NotificationItem(notification: n, onMarkRead: onMarkRead);
                },
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: GestureDetector(
                onTap: onMarkAllRead,
                child: const Center(
                  child: Text('Mark all as read', style: TextStyle(fontSize: 12, color: Color(0xFF00BCD4))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final AppNotification notification;
  final Function(String) onMarkRead;

  const _NotificationItem({required this.notification, required this.onMarkRead});

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    Color bgColor;
    IconData icon;
    switch (notification.type) {
      case 'alert':
        icon = Icons.warning_amber;
        iconColor = Colors.red.shade400;
        bgColor = Colors.red.withOpacity(0.1);
        break;
      case 'saving':
        icon = Icons.currency_rupee;
        iconColor = Colors.green.shade400;
        bgColor = Colors.green.withOpacity(0.1);
        break;
      default:
        icon = Icons.flash_on;
        iconColor = Colors.blue.shade400;
        bgColor = Colors.blue.withOpacity(0.1);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: !notification.read ? Colors.blue.withOpacity(0.05) : null,
        border: const Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: !notification.read ? Colors.white : Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Text(notification.message, style: const TextStyle(fontSize: 12, color: Colors.white54)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: Colors.white54),
                    const SizedBox(width: 4),
                    Text(notification.time, style: const TextStyle(fontSize: 10, color: Colors.white54)),
                  ],
                ),
              ],
            ),
          ),
          if (!notification.read)
            GestureDetector(
              onTap: () => onMarkRead(notification.id),
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(color: Color(0xFF1B4F8A), shape: BoxShape.circle),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProfileDropdown extends StatelessWidget {
  final VoidCallback onClose;

  const _ProfileDropdown({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 288,
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white10)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF1B4F8A), Color(0xFF00BCD4)]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: Icon(Icons.person, color: Colors.white, size: 24)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Avinash', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('Flat A-301 • GreenValley', style: TextStyle(fontSize: 12, color: Colors.white54)),
                    ],
                  ),
                ],
              ),
            ),
            // Stats
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _ProfileStatRow(icon: Icons.trending_down, label: 'This month savings', value: '₹1,240', color: Colors.green),
                  const SizedBox(height: 12),
                  _ProfileStatRow(icon: Icons.eco, label: 'CO₂ saved', value: '36.9 kg', color: Colors.green.shade700),
                  const SizedBox(height: 12),
                  _ProfileStatRow(icon: Icons.flash_on, label: 'Energy score', value: '⚡94', color: Colors.amber),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ProfileStatRow({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white54),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.white54))),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color)),
      ],
    );
  }
}