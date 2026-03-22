import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod/src/providers/legacy/state_notifier_provider.dart';

final alertsProvider = StateNotifierProvider<AlertsNotifier, List<Alert>>((ref) {
  return AlertsNotifier(_initialAlerts);
});

class AlertsNotifier extends StateNotifier<List<Alert>> {
  AlertsNotifier(super.initial);

  void markAsRead(String id) {
    state = state.map((a) => a.id == id ? a.copyWith(read: true) : a).toList();
  }

  void markAllAsRead() {
    state = state.map((a) => a.copyWith(read: true)).toList();
  }

  void addAlert(Alert alert) {
    state = [alert, ...state];
  }
}

class Alert {
  final String id;
  final String type; // tariff, saving, anomaly
  final String title;
  final String message;
  final String time;
  final bool read;

  Alert({required this.id, required this.type, required this.title, required this.message, required this.time, required this.read});

  Alert copyWith({bool? read}) {
    return Alert(
      id: id,
      type: type,
      title: title,
      message: message,
      time: time,
      read: read ?? this.read,
    );
  }
}

final _initialAlerts = [
  Alert(id: '1', type: 'tariff', title: 'Peak Tariff Alert!', message: 'Tariff shifted to ₹8.5/kWh. Avoid heavy appliances.', time: '2 min ago', read: false),
  Alert(id: '2', type: 'saving', title: 'You saved ₹47 today!', message: 'Smart scheduling saved you ₹47 by shifting your geyser to Sasta tariff hours.', time: '1 hr ago', read: false),
  Alert(id: '3', type: 'anomaly', title: 'Unusual Usage Detected', message: 'Your AC consumed 50% more than usual yesterday.', time: '3 hrs ago', read: true),
];
