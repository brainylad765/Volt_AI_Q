import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/billing_result.dart';

class ApiClient {
  static const String _baseUrl = 'http://localhost:8000';

  Future<BillingResult> simulateBilling({
    required List<String> appliances,
    required int hours,
    required double budget,
    required double comfort,
    required String discom,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/billing/simulate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'appliances': appliances,
          'hours': hours,
          'budget': budget,
          'comfort': comfort,
          'discom': discom,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BillingResult(
          baseline: (data['baseline'] as num).toDouble(),
          optimized: (data['optimized'] as num).toDouble(),
          savings: (data['savings'] as num).toDouble(),
          savingsPercent: (data['savingsPercent'] as num).toDouble(),
          co2Saved: (data['co2Saved'] as num).toDouble(),
          treesEquivalent: data['treesEquivalent'],
          monthlyData: (data['monthlyData'] as List).map((m) => MonthlyBill(
            month: m['month'],
            baseline: (m['baseline'] as num).toDouble(),
            optimized: (m['optimized'] as num).toDouble(),
          )).toList(),
        );
      } else {
        throw Exception('Failed to simulate');
      }
    } catch (e) {
      // Fallback mock data
      return BillingResult(
        baseline: 847,
        optimized: 620,
        savings: 227,
        savingsPercent: 26.8,
        co2Saved: 36.9,
        treesEquivalent: 2,
        monthlyData: [
          MonthlyBill(month: 'Oct', baseline: 890, optimized: 650),
          MonthlyBill(month: 'Nov', baseline: 850, optimized: 620),
          MonthlyBill(month: 'Dec', baseline: 920, optimized: 680),
          MonthlyBill(month: 'Jan', baseline: 780, optimized: 570),
          MonthlyBill(month: 'Feb', baseline: 847, optimized: 620),
          MonthlyBill(month: 'Mar', baseline: 810, optimized: 590),
        ],
      );
    }
  }
}

