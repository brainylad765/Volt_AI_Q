import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/data/providers/appliance_provider.dart';
import 'package:volt_ai_q/ui/main_app/screens/appliances/widgets/appliance_card.dart';

class AppliancesScreen extends ConsumerStatefulWidget {
  const AppliancesScreen({super.key});

  @override
  ConsumerState<AppliancesScreen> createState() => _AppliancesScreenState();
}

class _AppliancesScreenState extends ConsumerState<AppliancesScreen> {
  String _selectedCategory = 'All';
  String? _selectedApplianceId;

  @override
  Widget build(BuildContext context) {
    final appliances = ref.watch(applianceProvider);
    final categories = ['All', ...appliances.map((a) => a.category).toSet()];

    final filtered = _selectedCategory == 'All'
        ? appliances
        : appliances.where((a) => a.category == _selectedCategory).toList();

    final totalKW = appliances.where((a) => a.isOn).fold(0.0, (s, a) => s + a.kw);
    final totalMonthlyCost = appliances.fold(0.0, (s, a) => s + a.monthlyCost);
    final smartCount = appliances.where((a) => a.smartEnabled).length;
    final onCount = appliances.where((a) => a.isOn).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Appliances')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Quick stats
            Row(
              children: [
                _StatCard(
                  icon: Icons.power,
                  label: 'Active Now',
                  value: '$onCount / ${appliances.length}',
                  color: Colors.green,
                ),
                const SizedBox(width: 16),
                _StatCard(
                  icon: Icons.flash_on,
                  label: 'Current Load',
                  value: '${totalKW.toStringAsFixed(2)} kW',
                  color: Colors.cyan,
                ),
                const SizedBox(width: 16),
                _StatCard(
                  icon: Icons.trending_down,
                  label: 'Monthly Cost',
                  value: '₹${totalMonthlyCost.toInt()}',
                  color: Colors.blue,
                ),
                const SizedBox(width: 16),
                _StatCard(
                  icon: Icons.smart_toy,
                  label: 'Smart Enabled',
                  value: '$smartCount appliances',
                  color: Colors.amber,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Category filter
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(cat),
                      selected: _selectedCategory == cat,
                      onSelected: (_) => setState(() => _selectedCategory = cat),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Grid of appliances
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final app = filtered[index];
                return ApplianceCard(
                  appliance: app,
                  isExpanded: _selectedApplianceId == app.id,
                  onTap: () {
                    setState(() {
                      _selectedApplianceId = _selectedApplianceId == app.id ? null : app.id;
                    });
                  },
                  onToggle: () {
                    ref.read(applianceProvider.notifier).toggleAppliance(app.id);
                  },
                );
              },
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
  final Color color;

  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

