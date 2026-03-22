import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volt_ai_q/ui/main_app/widgets/floating_chat_button.dart';
import 'package:volt_ai_q/ui/main_app/widgets/chat_overlay.dart';
import 'package:volt_ai_q/ui/widgets/energy_background.dart';

class MainAppScaffold extends ConsumerStatefulWidget {
  final Widget child;
  const MainAppScaffold({super.key, required this.child});

  @override
  ConsumerState<MainAppScaffold> createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends ConsumerState<MainAppScaffold> {
  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/appliances')) return 1;
    if (location.startsWith('/optimization')) return 2;
    if (location.startsWith('/chat')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/appliances');
        break;
      case 2:
        context.go('/optimization');
        break;
      case 3:
        context.go('/chat');
        break;
      case 4:
        context.go('/insights'); // Redirecting profile to insights for now as profile might be empty
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final currentIndex = _getSelectedIndex(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: EnergyBackground(
        child: Stack(
          children: [
            widget.child,
            const Positioned(
              bottom: 100,
              right: 16,
              child: FloatingChatButton(),
            ),
            const ChatOverlay(),
          ],
        ),
      ),
      bottomNavigationBar: isMobile
          ? Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (i) => _onItemTapped(i, context),
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color(0xFF0A0E1A),
                selectedItemColor: Colors.cyan,
                unselectedItemColor: Colors.white38,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontSize: 10),
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.devices_other), label: 'Devices'),
                  BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Optimize'),
                  BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'AI Chat'),
                  BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Insights'),
                ],
              ),
            )
          : null,
    );
  }
}
