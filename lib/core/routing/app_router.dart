import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volt_ai_q/data/providers/auth_provider.dart';
import 'package:volt_ai_q/ui/auth/login_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/alerts/alerts_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/appliances/appliances_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/architecture/architecture_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/billing/billing_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/carbon/carbon_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/chat/chat_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/contact/contact_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/energy_usage/energy_usage_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/insights/insights_screen.dart';
import 'package:volt_ai_q/ui/main_app/screens/optimization/optimization_screen.dart';
import 'package:volt_ai_q/ui/onboarding/onboarding_screen.dart';
import 'package:volt_ai_q/ui/main_app/main_app_scaffold.dart';
import 'package:volt_ai_q/ui/main_app/screens/dashboard/dashboard_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuth = authState is AuthenticatedState;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isAuth) {
        return isLoginRoute ? null : '/login';
      }

      final user = (authState).user;
      final isOnboardingComplete = user.isOnboardingComplete;
      final isOnboardingRoute = state.matchedLocation == '/onboarding';

      if (!isOnboardingComplete) {
        return isOnboardingRoute ? null : '/onboarding';
      }

      // If auth and onboarding complete, don't allow login or onboarding screens
      if (isLoginRoute || isOnboardingRoute) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainAppScaffold(child: child),
        routes: [
          GoRoute(path: '/dashboard', name: 'dashboard', builder: (context, state) => const DashboardScreen()),
          GoRoute(path: '/energy-usage', name: 'energy-usage', builder: (context, state) => const EnergyUsageScreen()),
          GoRoute(path: '/appliances', name: 'appliances', builder: (context, state) => const AppliancesScreen()),
          GoRoute(path: '/billing', name: 'billing', builder: (context, state) => const BillingScreen()),
          GoRoute(path: '/carbon', name: 'carbon', builder: (context, state) => const CarbonScreen()),
          GoRoute(path: '/architecture', name: 'architecture', builder: (context, state) => const ArchitectureScreen()),
          GoRoute(path: '/contact', name: 'contact', builder: (context, state) => const ContactScreen()),
          GoRoute(path: '/optimization', name: 'optimization', builder: (context, state) => const OptimizationScreen()),
          GoRoute(path: '/insights', name: 'insights', builder: (context, state) => const InsightsScreen()),
          GoRoute(path: '/alerts', name: 'alerts', builder: (context, state) => const AlertsScreen()),
          GoRoute(path: '/chat', name: 'chat', builder: (context, state) => const ChatScreen()),
        ],
      ),
    ],
  );
});
