import 'package:flutter_riverpod/legacy.dart';

final optimizationProvider = StateNotifierProvider<OptimizationNotifier, OptimizationState>((ref) {
  return OptimizationNotifier();
});

class OptimizationNotifier extends StateNotifier<OptimizationState> {
  OptimizationNotifier() : super(OptimizationInitial());

  Future<void> runOptimization() async {
    state = OptimizationLoading();
    await Future.delayed(const Duration(seconds: 3));
    // Simulate result
    final result = OptimizationResult(
      baseline: 61.40,
      optimized: 47.20,
      savings: 14.20,
      savingsPercent: 23.1,
      schedule: {
        'Air Conditioner': '10:00-14:00 (Off-peak)',
        'Geyser': '06:00-06:30 (Sasta)',
        'Washing Machine': '22:00-23:00 (Sasta)',
      },
    );
    state = OptimizationLoaded(result: result);
  }
}

abstract class OptimizationState {}

class OptimizationInitial extends OptimizationState {}

class OptimizationLoading extends OptimizationState {}

class OptimizationLoaded extends OptimizationState {
  final OptimizationResult result;
  OptimizationLoaded({required this.result});
}

class OptimizationError extends OptimizationState {
  final String message;
  OptimizationError(this.message);
}

class OptimizationResult {
  final double baseline;
  final double optimized;
  final double savings;
  final double savingsPercent;
  final Map<String, String> schedule;

  OptimizationResult({
    required this.baseline,
    required this.optimized,
    required this.savings,
    required this.savingsPercent,
    required this.schedule,
  });
}
