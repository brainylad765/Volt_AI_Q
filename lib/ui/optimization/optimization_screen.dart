import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volt_ai_q/data/providers/optimization_provider.dart';

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
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 4));
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
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: AppBar(
        title: const Text('AI Optimization Engine', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading
          ? _LoadingPipeline(animationController: _animationController)
          : result != null
              ? _OptimizationResult(result: result)
              : Center(child: Text('Error: ${state is OptimizationError ? state.message : 'Unknown'}', style: const TextStyle(color: Colors.red))),
    );
  }
}

class _LoadingPipeline extends StatelessWidget {
  final AnimationController animationController;

  const _LoadingPipeline({required this.animationController});

  @override
  Widget build(BuildContext context) {
    final steps = [
      'Neural Network Prediction (LSTM)',
      'XGBoost Tariff Classification',
      'MILP Resource Optimization',
      'Schedule Generation'
    ];
    
    return Stack(
      children: [
        // Background scanning effect
        Positioned.fill(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: _ScanlinePainter(progress: animationController.value),
              );
            },
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: steps.asMap().entries.map((entry) {
                      final index = entry.key;
                      final step = entry.value;
                      
                      return AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          final stepProgress = (animationController.value * steps.length);
                          final isDone = stepProgress > index + 1;
                          final isCurrent = stepProgress > index && stepProgress <= index + 1;
                          
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  child: isDone
                                      ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
                                      : isCurrent
                                          ? const SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.cyan)),
                                            )
                                          : const Icon(Icons.circle_outlined, color: Colors.white24, size: 20),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    step,
                                    style: TextStyle(
                                      color: isDone ? Colors.white : (isCurrent ? Colors.cyan : Colors.white54),
                                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'ENGINEERING OPTIMAL SCHEDULE...',
                  style: TextStyle(color: Colors.cyan, letterSpacing: 2, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ScanlinePainter extends CustomPainter {
  final double progress;
  _ScanlinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.cyan.withOpacity(0),
          Colors.cyan.withOpacity(0.1),
          Colors.cyan.withOpacity(0),
        ],
      ).createShader(Rect.fromLTWH(0, (progress * size.height) % size.height - 50, size.width, 100));
    
    canvas.drawRect(Rect.fromLTWH(0, (progress * size.height) % size.height - 50, size.width, 100), paint);

    // Grid lines
    final gridPaint = Paint()
      ..color = Colors.cyan.withOpacity(0.05)
      ..strokeWidth = 0.5;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScanlinePainter oldDelegate) => oldDelegate.progress != progress;
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
          _buildSummaryCard(result),
          const SizedBox(height: 32),
          const Text('OPTIMIZED SCHEDULE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan, letterSpacing: 1.2)),
          const SizedBox(height: 16),
          ...result.schedule.entries.map((entry) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.cyan.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.flash_on, color: Colors.cyan, size: 20),
                ),
                title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: Text('Best time: ${entry.value}', style: const TextStyle(color: Colors.white70)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white24),
              ),
            );
          }),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Optimal schedule deployed to smart meter'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Apply Optimization', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Back to Dashboard', style: TextStyle(color: Colors.white54)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(OptimizationResult result) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B4F8A), Color(0xFF0D2A4D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.cyan.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('POTENTIAL SAVINGS', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                  Text('This Month', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                child: Text('${result.savingsPercent.toStringAsFixed(1)}% OFF', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildPriceCol('Before', '₹${result.baseline.toStringAsFixed(0)}', Colors.white38),
              ),
              const Icon(Icons.arrow_forward, color: Colors.white24),
              Expanded(
                child: _buildPriceCol('After AI', '₹${result.optimized.toStringAsFixed(0)}', Colors.greenAccent),
              ),
            ],
          ),
          const Divider(height: 32, color: Colors.white10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Total Savings: ', style: TextStyle(color: Colors.white70)),
              Text('₹${result.savings.toStringAsFixed(2)}', style: const TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCol(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        Text(value, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
