import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/appliance.dart';

final applianceProvider = StateNotifierProvider<ApplianceNotifier, List<Appliance>>((ref) {
  return ApplianceNotifier(_initialAppliances);
});

class ApplianceNotifier extends StateNotifier<List<Appliance>> {
  ApplianceNotifier(super.initial);

  void toggleAppliance(String id) {
    state = [
      for (final app in state)
        if (app.id == id) app.copyWith(isOn: !app.isOn) else app
    ];
  }
}

final _initialAppliances = [
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
  Appliance(
    id: 'geyser',
    name: 'Geyser',
    category: 'Heating',
    kw: 2.0,
    dailyHours: 1,
    monthlyCost: 93,
    isOn: false,
    smartEnabled: true,
    schedule: '05:30 AM - 06:00 AM',
    iconName: 'Droplets',
  ),
  Appliance(
    id: 'wm',
    name: 'Washing Machine',
    category: 'Laundry',
    kw: 0.5,
    dailyHours: 1,
    monthlyCost: 35,
    isOn: false,
    smartEnabled: true,
    schedule: '06:00 AM - 06:45 AM',
    iconName: 'WashingMachine',
  ),
  Appliance(
    id: 'tv',
    name: 'Television',
    category: 'Entertainment',
    kw: 0.1,
    dailyHours: 5,
    monthlyCost: 15,
    isOn: true,
    smartEnabled: false,
    iconName: 'Tv',
  ),
  Appliance(
    id: 'lights',
    name: 'Lighting',
    category: 'Lighting',
    kw: 0.06,
    dailyHours: 10,
    monthlyCost: 18,
    isOn: true,
    smartEnabled: false,
    iconName: 'Lightbulb',
  ),
  Appliance(
    id: 'refrigerator',
    name: 'Refrigerator',
    category: 'Cooling',
    kw: 0.3,
    dailyHours: 24,
    monthlyCost: 108,
    isOn: true,
    smartEnabled: false,
    iconName: 'Refrigerator',
  ),
  Appliance(
    id: 'fan',
    name: 'Fan',
    category: 'Cooling',
    kw: 0.05,
    dailyHours: 12,
    monthlyCost: 24,
    isOn: true,
    smartEnabled: false,
    iconName: 'Fan',
  ),
];
