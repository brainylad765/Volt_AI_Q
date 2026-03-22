import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:volt_ai_q/data/models/appliance.dart';
import 'package:volt_ai_q/data/models/colony_data.dart';
import 'package:volt_ai_q/data/models/tariff_mode.dart';

// Live KW provider
final liveKWProvider = StateProvider<double>((ref) => 142.7);

// WebSocket connected status
final wsConnectedProvider = StateProvider<bool>((ref) => false);

// Colony data provider
final colonyDataProvider = StateProvider<ColonyData>((ref) => defaultColonyData);

// Appliances provider
final appliancesProvider = StateNotifierProvider<AppliancesNotifier, List<Appliance>>((ref) {
  return AppliancesNotifier(defaultAppliances);
});

class AppliancesNotifier extends StateNotifier<List<Appliance>> {
  AppliancesNotifier(super.initial);

  void toggleAppliance(String id) {
    state = state.map((app) {
      if (app.id == id) {
        return app.copyWith(isOn: !app.isOn);
      }
      return app;
    }).toList();
  }
}

final defaultAppliances = [
  Appliance(
    id: 'ac',
    name: 'Air Conditioner',
    category: 'Cooling',
    kw: 1.5,
    dailyHours: 8,
    monthlyCost: 540,
    isOn: true,
    smartEnabled: true,
    schedule: '09:00 AM - 12:00 PM',
    iconName: 'AirVent',
  ),
];
