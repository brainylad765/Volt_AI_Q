import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/billing_result.dart';

final billingProvider = FutureProvider<BillingResult>((ref) async {
  // Simulate API call
  await Future.delayed(const Duration(milliseconds: 500));
  return BillingResult(
    baseline: 847,
    optimized: 620,
    savings: 227,
    savingsPercent: 26.8,
    monthlyData: [
      MonthlyBill(month: 'Oct', baseline: 890, optimized: 650),
      MonthlyBill(month: 'Nov', baseline: 850, optimized: 620),
      MonthlyBill(month: 'Dec', baseline: 920, optimized: 680),
      MonthlyBill(month: 'Jan', baseline: 780, optimized: 570),
      MonthlyBill(month: 'Feb', baseline: 847, optimized: 620),
      MonthlyBill(month: 'Mar', baseline: 810, optimized: 590),
    ],
    co2Saved: 36.9,
    treesEquivalent: 10,
  );
});

final billingSimulationProvider = StateProvider<BillingResult?>((ref) => null);
final billingSimulationModeProvider = StateProvider<bool>((ref) => false);
