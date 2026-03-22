import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/data/providers/optimization_provider.dart';
import 'package:go_router/go_router.dart';

class OptimizationScreen extends ConsumerStatefulWidget {
  const OptimizationScreen({super.key});

  @override
  ConsumerState<OptimizationScreen> createState() => _OptimizationScreenState();
}

class _OptimizationScreenState extends ConsumerState<OptimizationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(optimizationProvider.notifier).runOptimization();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(optimizationProvider);
    final isLoading = state is OptimizationLoading;
    final result = state is OptimizationLoaded ? state.result : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Optimization Engine')),
      body: isLoading
          ? _LoadingPipeline(animationController: _animationController)
          : result != null
              ? _OptimizationResult(result: result)
              : OutlinedButton(
                onPressed: () {
                  context.go('/dashboard');  // ✅ Now works
                  },
                  child: const Text('Back to Dashboard'),
                ),
      );
    }
}

class _LoadingPipeline extends StatelessWidget {
  final AnimationController animationController;

  const _LoadingPipeline({required this.animationController});

  @override
  Widget build(BuildContext context) {
    final steps = ['LSTM Prediction', 'XGBoost Classification', 'MILP Optimization'];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          ...steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final progress = animationController.value * steps.length;
            final isDone = progress > index;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isDone ? Icons.check_circle : Icons.circle_outlined,
                    color: isDone ? Colors.green : Colors.white54,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(step, style: TextStyle(color: isDone ? Colors.white : Colors.white54)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _OptimizationResult extends StatelessWidget {
  final OptimizationResult result;

  const _OptimizationResult({required this.result});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Savings Comparison', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text('Without VoltIQ', style: TextStyle(color: Colors.white54)),
                        Text('₹${result.baseline.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  color: Colors.green.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text('With VoltIQ', style: TextStyle(color: Colors.green)),
                        Text('₹${result.optimized.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Savings', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('₹${result.savings.toStringAsFixed(2)} (${result.savingsPercent.toStringAsFixed(1)}%)', style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Optimized Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...result.schedule.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              subtitle: Text(entry.value),
              trailing: const Icon(Icons.schedule),
            );
          }),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Apply schedule logic
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Schedule applied!')),
                      );
                    }
                  },
                  child: const Text('Apply Schedule'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.go('/dashboard');
                  },
                  child: const Text('Back to Dashboard'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
