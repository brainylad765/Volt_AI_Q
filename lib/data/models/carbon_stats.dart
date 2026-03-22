import 'package:flutter/material.dart';

class CarbonStats {
  final double totalCo2Saved; // kg
  final double treesEquivalent;
  final double reductionPercent;
  final int greenScore;
  final List<MonthlyCarbon> monthlyData;
  final List<CarbonEquivalent> equivalents;
  final List<GreenBadge> badges;
  final List<EnergyMix> gridMix;

  CarbonStats({
    required this.totalCo2Saved,
    required this.treesEquivalent,
    required this.reductionPercent,
    required this.greenScore,
    required this.monthlyData,
    required this.equivalents,
    required this.badges,
    required this.gridMix,
  });
}

class MonthlyCarbon {
  final String month;
  final double saved;
  final double emitted;

  MonthlyCarbon({required this.month, required this.saved, required this.emitted});
}

class CarbonEquivalent {
  final String label;
  final String value;
  final String iconName;

  CarbonEquivalent({required this.label, required this.value, required this.iconName});
}

class GreenBadge {
  final String title;
  final bool achieved;
  final String icon;

  GreenBadge({required this.title, required this.achieved, required this.icon});
}

class EnergyMix {
  final String name;
  final double percentage;
  final Color fillColor;

  EnergyMix({required this.name, required this.percentage, required this.fillColor});
}
