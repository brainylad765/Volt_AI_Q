class BillingResult {
  final double baseline; // bill without VoltIQ
  final double optimized; // bill with VoltIQ
  final double savings;
  final double savingsPercent;
  final List<MonthlyBill> monthlyData;
  final double co2Saved;
  final int treesEquivalent;

  BillingResult({
    required this.baseline,
    required this.optimized,
    required this.savings,
    required this.savingsPercent,
    required this.monthlyData,
    required this.co2Saved,
    required this.treesEquivalent,
  });
}

class MonthlyBill {
  final String month;
  final double baseline;
  final double optimized;

  MonthlyBill({required this.month, required this.baseline, required this.optimized});
}
