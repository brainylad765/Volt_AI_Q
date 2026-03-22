import 'package:flutter_riverpod/legacy.dart';
import '../models/tariff_mode.dart';

final tariffModeProvider = StateProvider<TariffMode>((ref) => TariffMode.mid);
