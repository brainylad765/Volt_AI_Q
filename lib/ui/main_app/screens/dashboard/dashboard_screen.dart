import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/ui/widgets/animated_counter.dart';
import 'package:volt_ai_q/ui/widgets/glass_card.dart';
import 'package:volt_ai_q/ui/main_app/screens/dashboard/widgets/energy_flow_scene.dart';
import 'package:go_router/go_router.dart';

class OverviewCard extends StatelessWidget {
  final String title, route;
  final IconData icon;
  final List<StatItem> stats;
  const OverviewCard({super.key, required this.title, required this.route, required this.icon, required this.stats});
  @override
  Widget build(BuildContext context) {
    // Extract numerical value from string like "35.4 kWh"
    final double val = double.tryParse(stats[0].value.split(' ')[0]) ?? 0;
    final String unit = stats[0].value.contains(' ') ? stats[0].value.split(' ')[1] : "";

    return InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(24),
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 24, color: Colors.cyan),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
                ],
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  AnimatedCounter(
                    end: val,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  if (unit.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(unit, style: const TextStyle(fontSize: 12, color: Colors.white54)),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                stats[0].label,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 600.ms).scale(delay: 100.ms),
    );
  }
}

class StatItem {
  final String label, value;
  final bool highlight;
  const StatItem({required this.label, required this.value, this.highlight = false});
}

class WelcomeHeader extends StatelessWidget {
  final String name;
  const WelcomeHeader({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $name',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ).animate().fadeIn().slideX(),
        const Text(
          'Your energy ecosystem is healthy.',
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ).animate().fadeIn(delay: 200.ms).slideX(),
      ],
    );
  }
}

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.bottomLeft,
                child: const WelcomeHeader(name: 'Avinash'),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () => context.go('/alerts'),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Active optimization banner
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.cyan.withOpacity(0.2), Colors.cyan.withOpacity(0.05)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.cyan.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      _PulseIcon(),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'VoltIQ Active Optimization',
                              style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Text(
                              'Saved ₹227 this month through smart scheduling.',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn().slideY(begin: 0.2),
                
                const SizedBox(height: 32),
                
                // Live energy flow
                const Text(
                  'LIVE ENERGY FLOW',
                  style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const EnergyFlowScene().animate().fadeIn(delay: 400.ms),
                
                const SizedBox(height: 32),
                
                const Text(
                  'SYSTEM INSIGHTS',
                  style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: const [
                    OverviewCard(
                      title: 'Usage',
                      route: '/energy-usage',
                      icon: Icons.bar_chart_rounded,
                      stats: [StatItem(label: "Today's Usage", value: '35.4 kWh')],
                    ),
                    OverviewCard(
                      title: 'Devices',
                      route: '/appliances',
                      icon: Icons.devices_other_rounded,
                      stats: [StatItem(label: 'Active Now', value: '6')],
                    ),
                    OverviewCard(
                      title: 'Savings',
                      route: '/billing',
                      icon: Icons.account_balance_wallet_rounded,
                      stats: [StatItem(label: 'Monthly Savings', value: '227 ₹')],
                    ),
                    OverviewCard(
                      title: 'Eco Score',
                      route: '/carbon',
                      icon: Icons.eco_rounded,
                      stats: [StatItem(label: 'Green Score', value: '78')],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseIcon extends StatefulWidget {
  @override
  State<_PulseIcon> createState() => _PulseIconState();
}

class _PulseIconState extends State<_PulseIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.cyan,
            boxShadow: [
              BoxShadow(
                color: Colors.cyan.withOpacity(0.5),
                blurRadius: 10 * _controller.value,
                spreadRadius: 5 * _controller.value,
              )
            ],
          ),
        );
      },
    );
  }
}
