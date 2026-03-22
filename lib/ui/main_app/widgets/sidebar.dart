import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  bool _collapsed = false;

  final List<NavItem> _navItems = [
    NavItem(icon: Icons.home, label: 'Home', route: '/'),
    NavItem(icon: Icons.dashboard, label: 'Dashboard Overview', route: '/dashboard'),
    NavItem(icon: Icons.bar_chart, label: 'Energy Usage & Schedules', route: '/energy-usage'),
    NavItem(icon: Icons.devices, label: 'Appliances', route: '/appliances'),
    NavItem(icon: Icons.receipt, label: 'Billing & Saving', route: '/billing'),
    NavItem(icon: Icons.eco, label: 'Carbon Footprints', route: '/carbon'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _collapsed ? 72 : 260,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0A0E1A),
          border: Border(right: BorderSide(color: Colors.white10)),
        ),
        child: Column(
          children: [
            // Logo
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white10)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF00BCD4), Color(0xFF1B4F8A)]),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Center(child: Icon(Icons.flash_on, color: Colors.white, size: 20)),
                  ),
                  if (!_collapsed) const SizedBox(width: 12),
                  if (!_collapsed)
                    const Expanded(
                      child: Text(
                        'VoltIQ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            // Navigation items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: _navItems.length,
                itemBuilder: (context, index) {
                  final item = _navItems[index];
                  final isActive = currentPath == item.route ||
                      (item.route != '/' && currentPath.startsWith(item.route));

                  return GestureDetector(
                    onTap: () => context.go(item.route),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFF1B4F8A) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isActive
                            ? [BoxShadow(color: const Color(0xFF1B4F8A).withOpacity(0.2), blurRadius: 12)]
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(item.icon, size: 20, color: isActive ? Colors.white : Colors.white54),
                          if (!_collapsed) const SizedBox(width: 12),
                          if (!_collapsed)
                            Expanded(
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                  color: isActive ? Colors.white : Colors.white70,
                                ),
                              ),
                            ),
                          if (isActive && !_collapsed)
                            Container(
                              width: 4,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00BCD4),
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(2)),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Collapse button
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: GestureDetector(
                onTap: () => setState(() => _collapsed = !_collapsed),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_collapsed ? Icons.chevron_right : Icons.chevron_left, size: 20, color: Colors.white54),
                      if (!_collapsed) const SizedBox(width: 8),
                      if (!_collapsed) const Text('Collapse', style: TextStyle(fontSize: 12, color: Colors.white54)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;
  final String route;

  NavItem({required this.icon, required this.label, required this.route});
}