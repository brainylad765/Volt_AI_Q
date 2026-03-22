import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/carbon_stats.dart';

final carbonProvider = FutureProvider<CarbonStats>((ref) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return CarbonStats(
    totalCo2Saved: 205.9,
    treesEquivalent: 10.5,
    reductionPercent: 39,
    greenScore: 78,
    monthlyData: [
      MonthlyCarbon(month: 'Oct', saved: 32, emitted: 58),
      MonthlyCarbon(month: 'Nov', saved: 34, emitted: 52),
      MonthlyCarbon(month: 'Dec', saved: 30, emitted: 62),
      MonthlyCarbon(month: 'Jan', saved: 38, emitted: 48),
      MonthlyCarbon(month: 'Feb', saved: 36.9, emitted: 50),
      MonthlyCarbon(month: 'Mar', saved: 35, emitted: 47),
    ],
    equivalents: [
      CarbonEquivalent(label: 'Trees planted (equivalent)', value: '10.5 trees', iconName: 'TreePine'),
      CarbonEquivalent(label: 'Coal not burned', value: '84 kg', iconName: 'Factory'),
      CarbonEquivalent(label: 'Water saved', value: '3,200 L', iconName: 'Droplets'),
      CarbonEquivalent(label: 'Clean air days', value: '12 days', iconName: 'Wind'),
    ],
    badges: [
      GreenBadge(title: 'First 50 kg CO₂ Saved', achieved: true, icon: '🌱'),
      GreenBadge(title: '100 kg CO₂ Saved', achieved: true, icon: '🌿'),
      GreenBadge(title: '200 kg CO₂ Saved', achieved: false, icon: '🌳'),
      GreenBadge(title: 'Colony Top 10 Saver', achieved: true, icon: '🏆'),
      GreenBadge(title: 'Zero Peak Day', achieved: true, icon: '⚡'),
      GreenBadge(title: '10 Trees Equivalent', achieved: true, icon: '🌲'),
    ],
    gridMix: [
      EnergyMix(name: 'Coal', percentage: 55, fillColor: Colors.grey.shade700),
      EnergyMix(name: 'Solar', percentage: 15, fillColor: Colors.amber),
      EnergyMix(name: 'Wind', percentage: 12, fillColor: Colors.cyan),
      EnergyMix(name: 'Hydro', percentage: 10, fillColor: Colors.blue.shade800),
      EnergyMix(name: 'Nuclear', percentage: 5, fillColor: Colors.purple),
      EnergyMix(name: 'Gas', percentage: 3, fillColor: Colors.red),
    ],
  );
});
