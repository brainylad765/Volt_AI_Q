import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:volt_ai_q/data/providers/energy_usage_provider.dart';
import 'package:volt_ai_q/data/models/hourly_usage.dart';
import 'package:volt_ai_q/data/models/weekly_usage.dart';
import 'package:volt_ai_q/ui/main_app/screens/energy_usage/widgets/schedule_item_widget.dart';
import 'package:volt_ai_q/ui/widgets/energy_background.dart';
import 'package:volt_ai_q/ui/widgets/glass_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EnergyUsageScreen extends ConsumerStatefulWidget {
  const EnergyUsageScreen({super.key});

  @override
  ConsumerState<EnergyUsageScreen> createState() => _EnergyUsageScreenState();
}

class _EnergyUsageScreenState extends ConsumerState<EnergyUsageScreen> {
  bool _isWeekly = false;

  @override
  Widget build(BuildContext context) {
    final hourlyData = ref.watch(hourlyUsageProvider);
    final weeklyData = ref.watch(weeklyUsageProvider);
    final scheduleItems = ref.watch(scheduleProvider);

    final totalToday = hourlyData.fold(0.0, (sum, item) => sum + item.usage);
    final peakUsage = hourlyData
        .where((h) => h.tariff == 'Peak')
        .fold(0.0, (sum, item) => sum + item.usage);
    final sastaUsage = hourlyData
        .where((h) => h.tariff == 'Sasta')
        .fold(0.0, (sum, item) => sum + item.usage);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Energy & Analytics', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: EnergyBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _CompactStatCard(
                      label: "Today's Usage",
                      value: totalToday.toStringAsFixed(1),
                      unit: 'kWh',
                      icon: Icons.flash_on,
                      color: Colors.cyan,
                    ),
                    const SizedBox(width: 12),
                    _CompactStatCard(
                      label: 'Savings',
                      value: '47',
                      unit: '₹',
                      icon: Icons.account_balance_wallet,
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(width: 12),
                    _CompactStatCard(
                      label: 'Peak Load',
                      value: peakUsage.toStringAsFixed(1),
                      unit: 'kWh',
                      icon: Icons.warning_amber_rounded,
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),
              
              const SizedBox(height: 32),

              // Consumption Chart
              const Text(
                'CONSUMPTION ANALYTICS',
                style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Power Distribution', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('Real-time tariff zones', style: TextStyle(color: Colors.white54, fontSize: 12)),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                _buildToggleButton('Day', !_isWeekly),
                                _buildToggleButton('Week', _isWeekly),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 220,
                        child: _isWeekly
                            ? _WeeklyChart(weeklyData: weeklyData)
                            : _HourlyChart(hourlyData: hourlyData),
                      ),
                      const SizedBox(height: 24),
                      if (!_isWeekly) _TariffLegend(),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms).scale(),

              const SizedBox(height: 32),

              // Smart Schedule
              const Text(
                'OPTIMIZED SCHEDULE',
                style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...scheduleItems.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ScheduleItemWidget(item: item),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1)),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool active) {
    return GestureDetector(
      onTap: () => setState(() => _isWeekly = label == 'Week'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.cyan : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.black : Colors.white54,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _CompactStatCard extends StatelessWidget {
  final String label, value, unit;
  final IconData icon;
  final Color color;

  const _CompactStatCard({required this.label, required this.value, required this.unit, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(width: 4),
              Text(unit, style: const TextStyle(fontSize: 12, color: Colors.white38)),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }
}

class _HourlyChart extends StatelessWidget {
  final List<HourlyUsage> hourlyData;
  const _HourlyChart({required this.hourlyData});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(color: Colors.white10, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 6,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index >= 0 && index < hourlyData.length && index % 6 == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(hourlyData[index].hour, style: const TextStyle(fontSize: 10, color: Colors.white38)),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: hourlyData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.usage)).toList(),
            isCurved: true,
            color: Colors.cyan,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.cyan.withOpacity(0.3), Colors.cyan.withOpacity(0)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyChart extends StatelessWidget {
  final List<WeeklyUsage> weeklyData;
  const _WeeklyChart({required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: weeklyData.asMap().entries.map((e) {
          return BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value.usage, 
                color: Colors.cyan, 
                width: 16, 
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                backDrawRodData: BackgroundBarChartRodData(show: true, toY: 20, color: Colors.white.withOpacity(0.05)),
              ),
            ],
          );
        }).toList(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index >= 0 && index < weeklyData.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(weeklyData[index].day.substring(0, 3), style: const TextStyle(color: Colors.white38, fontSize: 10)),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}

class _TariffLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _LegendItem(color: Colors.greenAccent, label: 'Sasta', rate: '₹3.1'),
        _LegendItem(color: Colors.orangeAccent, label: 'Mid', rate: '₹5.2'),
        _LegendItem(color: Colors.redAccent, label: 'Peak', rate: '₹8.5'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label, rate;
  const _LegendItem({required this.color, required this.label, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        const SizedBox(width: 4),
        Text(rate, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
