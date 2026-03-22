import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/notification.dart';

final notificationsProvider = StateNotifierProvider<NotificationNotifier, List<AppNotification>>((ref) {
  return NotificationNotifier(_initialNotifications);
});

class NotificationNotifier extends StateNotifier<List<AppNotification>> {
  NotificationNotifier(super.initial);

  void markAsRead(String id) {
    state = state.map((n) {
      if (n.id == id) return n.copyWith(read: true);
      return n;
    }).toList();
  }

  void markAllAsRead() {
    state = state.map((n) => n.copyWith(read: true)).toList();
  }

  void addNotification(AppNotification notification) {
    state = [notification, ...state];
  }
}

final _initialNotifications = [
  AppNotification(
    id: '1',
    type: 'alert',
    title: 'Peak Tariff Alert!',
    message: 'Tariff shifted to ₹8.5/kWh. Avoid heavy appliances for the next 2 hours.',
    time: '2 min ago',
    read: false,
  ),
  AppNotification(
    id: '2',
    type: 'saving',
    title: 'You saved ₹47 today!',
    message: 'Smart scheduling saved you ₹47 by shifting your geyser to Sasta tariff hours.',
    time: '1 hr ago',
    read: false,
  ),
  AppNotification(
    id: '3',
    type: 'info',
    title: 'Weekly Report Ready',
    message: 'Your weekly energy report shows 23% savings over baseline. Keep it up!',
    time: '3 hrs ago',
    read: true,
  ),
];
