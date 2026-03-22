import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:volt_ai_q/data/providers/insights_provider.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(insightsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Top stats row
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _StatCard(
                  icon: Icons.savings,
                  label: 'Total Savings',
                  value: '₹${insights.totalSavings.toStringAsFixed(0)}',
                  color: Colors.green,
                ),
                _StatCard(
                  icon: Icons.percent,
                  label: 'Avg Savings',
                  value: '${insights.avgSavingsPercent.toStringAsFixed(1)}%',
                  color: Colors.blue,
                ),
                _StatCard(
                  icon: Icons.eco,
                  label: 'CO₂ Saved',
                  value: '${insights.co2Saved.toStringAsFixed(1)} kg',
                  sub: '≈ ${insights.treesEquivalent} trees',
                  color: Colors.green,
                ),
                _StatCard(
                  icon: Icons.star,
                  label: 'Energy Score',
                  value: '${insights.energyScore}',
                  sub: 'Rank #${insights.colonyRank}',
                  color: Colors.amber,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Billing comparison chart
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Bill Comparison', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        barGroups: insights.monthlyData.asMap().entries.map((e) {
                          int index = e.key;
                          var data = e.value;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(toY: data.baseline, color: Colors.grey, width: 12),
                              BarChartRodData(toY: data.optimized, color: Colors.green, width: 12),
                            ],
                          );
                        }).toList(),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                if (index >= 0 && index < insights.monthlyData.length) {
                                  return Text(insights.monthlyData[index].month, style: const TextStyle(fontSize: 10));
                                }
                                return const Text('');
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Savings trend
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Savings Trend', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: insights.monthlyData.asMap().entries.map((e) {
                              int index = e.key;
                              var data = e.value;
                              return FlSpot(index.toDouble(), data.savings);
                            }).toList(),
                            color: Colors.green,
                            belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.1)),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                if (index >= 0 && index < insights.monthlyData.length) {
                                  return Text(insights.monthlyData[index].month, style: const TextStyle(fontSize: 10));
                                }
                                return const Text('');
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Carbon impact & score
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.eco, color: Colors.green),
                        const SizedBox(height: 8),
                        Text('${insights.co2Saved.toStringAsFixed(1)} kg CO₂'),
                        const Text('saved this year', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text('Energy Score', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: CircularProgressIndicator(
                                value: insights.energyScore / 100,
                                strokeWidth: 8,
                                backgroundColor: Colors.white24,
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                              ),
                            ),
                            Text('${insights.energyScore}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text('Rank #${insights.colonyRank}', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? sub;
  final Color color;

  const _StatCard({required this.icon, required this.label, required this.value, this.sub, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 12)),
          if (sub != null) Text(sub!, style: const TextStyle(fontSize: 10, color: Colors.white54)),
        ],
      ),
    );
  }
}