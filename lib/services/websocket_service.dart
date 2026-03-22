import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volt_ai_q/data/providers/alerts_provider.dart';
import 'package:volt_ai_q/data/providers/tariff_provider.dart';
import 'package:volt_ai_q/data/providers/live_kw_provider.dart';
import 'package:volt_ai_q/data/models/tariff_mode.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  Timer? _mockTimer;
  ProviderContainer? _container;

  void init(ProviderContainer container) {
    _container = container;
    _startMockUpdates();
  }

  void _startMockUpdates() {
    if (_mockTimer != null) return;
    _mockTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_container == null) return;
      final random = DateTime.now().millisecondsSinceEpoch % 100;

      // 1. Update tariff mode occasionally
      if (random < 10) {
        final modes = ['peak', 'mid', 'sasta'];
        final newMode = modes[random % 3];
        _container!.read(tariffModeProvider.notifier).state = _parseTariff(newMode);
      }

      // 2. Update live kW
      final currentKW = _container!.read(liveKWProvider);
      final newKW = currentKW + (random % 20 - 10) / 10;
      _container!.read(liveKWProvider.notifier).state = newKW.clamp(0, 500);

      // 3. Simulate alert
      if (random < 5) {
        final alert = Alert(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: 'tariff',
          title: 'Tariff Changed',
          message: 'Tariff mode is now ${_container!.read(tariffModeProvider)}',
          time: 'Just now',
          read: false,
        );
        _container!.read(alertsProvider.notifier).addAlert(alert);
      }
    });
  }

  TariffMode _parseTariff(String mode) {
    switch (mode) {
      case 'peak': return TariffMode.peak;
      case 'mid': return TariffMode.mid;
      case 'sasta': return TariffMode.sasta;
      default: return TariffMode.mid;
    }
  }

  void dispose() {
    _mockTimer?.cancel();
  }
}
