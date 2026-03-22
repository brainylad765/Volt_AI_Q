import 'package:flutter_riverpod/flutter_riverpod.dart';

final insightsProvider = Provider<InsightsData>((ref) {
  return InsightsData(
    totalSavings: 1367,
    avgSavingsPercent: 23.5,
    co2Saved: 205.9,
    treesEquivalent: 10,
    energyScore: 78,
    colonyRank: 15,
    monthlyData: [
      MonthlyBillData(month: 'Oct', baseline: 890, optimized: 650, savings: 240),
      MonthlyBillData(month: 'Nov', baseline: 850, optimized: 620, savings: 230),
      MonthlyBillData(month: 'Dec', baseline: 920, optimized: 680, savings: 240),
      MonthlyBillData(month: 'Jan', baseline: 780, optimized: 570, savings: 210),
      MonthlyBillData(month: 'Feb', baseline: 847, optimized: 620, savings: 227),
      MonthlyBillData(month: 'Mar', baseline: 810, optimized: 590, savings: 220),
    ],
  );
});

class InsightsData {
  final double totalSavings;
  final double avgSavingsPercent;
  final double co2Saved;
  final int treesEquivalent;
  final int energyScore;
  final int colonyRank;
  final List<MonthlyBillData> monthlyData;

  const InsightsData({
    required this.totalSavings,
    required this.avgSavingsPercent,
    required this.co2Saved,
    required this.treesEquivalent,
    required this.energyScore,
    required this.colonyRank,
    required this.monthlyData,
  });
}

class MonthlyBillData {
  final String month;
  final double baseline;
  final double optimized;
  final double savings;

  const MonthlyBillData({
    required this.month,
    required this.baseline,
    required this.optimized,
    required this.savings,
  });
}
