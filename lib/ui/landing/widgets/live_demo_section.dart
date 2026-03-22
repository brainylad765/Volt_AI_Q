import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LiveDemoSection extends StatelessWidget {
  const LiveDemoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      color: const Color(0xFF0A0E1A),
      child: Column(
        children: [
          const Text(
            'LIVE DEMO',
            style: TextStyle(
              color: Color(0xFF00BCD4),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'See it in action',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Real-time colony dashboard with live tariff monitoring and smart savings tracking.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 48),
          // Browser mockup
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              children: [
                // Browser bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    border: Border(bottom: BorderSide(color: Colors.white10)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 12, color: Colors.red),
                      const SizedBox(width: 8),
                      const Icon(Icons.circle, size: 12, color: Colors.amber),
                      const SizedBox(width: 8),
                      const Icon(Icons.circle, size: 12, color: Colors.green),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('voltiq.app/dashboard', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                // Dashboard preview
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Tariff banner preview
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.amber.withOpacity(0.2), Colors.amber.withOpacity(0.3), Colors.amber.withOpacity(0.2)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text('MID TARIFF', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const Text('₹5.2 / kWh', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Stats row
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 600) {
                            return Row(
                              children: [
                                _DemoStat(label: 'Colony Load', value: '142.7 kW', color: Colors.cyan),
                                _DemoStat(label: 'Homes Active', value: '200', color: Colors.white),
                                _DemoStat(label: 'Savings Today', value: '₹1,380', color: Colors.green),
                                _DemoStat(label: 'CO₂ Saved', value: '12.4 kg', color: Colors.green),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: _DemoStat(label: 'Colony Load', value: '142.7 kW', color: Colors.cyan)),
                                    Expanded(child: _DemoStat(label: 'Homes Active', value: '200', color: Colors.white)),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(child: _DemoStat(label: 'Savings Today', value: '₹1,380', color: Colors.green)),
                                    Expanded(child: _DemoStat(label: 'CO₂ Saved', value: '12.4 kg', color: Colors.green)),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      // Mini leaderboard
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.monitor, size: 16, color: Colors.cyan),
                                SizedBox(width: 8),
                                Text('Top Savers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _LeaderboardRow(rank: 1, flat: 'A-301', score: 94, savings: '₹1,240'),
                            const Divider(color: Colors.white10),
                            _LeaderboardRow(rank: 2, flat: 'B-108', score: 91, savings: '₹1,180'),
                            const Divider(color: Colors.white10),
                            _LeaderboardRow(rank: 3, flat: 'C-205', score: 88, savings: '₹1,090'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.go('/dashboard'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Open Full Dashboard →'),
          ),
        ],
      ),
    );
  }
}

class _DemoStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _DemoStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  final int rank;
  final String flat;
  final int score;
  final String savings;

  const _LeaderboardRow({required this.rank, required this.flat, required this.score, required this.savings});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text('#$rank', style: TextStyle(color: rank == 1 ? Colors.amber : Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
          Text(flat, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text('⚡$score', style: TextStyle(color: score >= 90 ? Colors.green : Colors.amber)),
          const SizedBox(width: 16),
          Text(savings, style: const TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}