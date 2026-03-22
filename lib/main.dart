import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/core/routing/app_router.dart';
import 'package:volt_ai_q/core/themes/app_theme.dart';
import 'package:volt_ai_q/services/websocket_service.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WebSocketService().init(ref.container);
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Volt_AI_Q',
      theme: appTheme(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}