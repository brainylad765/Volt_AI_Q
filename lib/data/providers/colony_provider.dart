import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/colony_data.dart';
import '../models/flat.dart';
enum TariffMode {peak, mid, sasta}
final colonyDataProvider = FutureProvider<ColonyData>((ref) async {
  // Simulate API call
  await Future.delayed(const Duration(milliseconds: 300));
  return ColonyData(
    totalKW: 142.7,
    totalHomes: 48,
    totalSaving: 152340,
    tariff: TariffMode.mid,
    flats: [
      Flat(rank: 1, flat: 'A-101', savings: 2340, energyScore: 94, kw: 1.8),
      Flat(rank: 2, flat: 'B-205', savings: 1890, energyScore: 88, kw: 2.1),
      Flat(rank: 3, flat: 'C-304', savings: 1760, energyScore: 85, kw: 2.3),
      Flat(rank: 4, flat: 'A-204', savings: 1520, energyScore: 79, kw: 2.5),
      Flat(rank: 5, flat: 'B-107', savings: 1480, energyScore: 76, kw: 2.6),
      Flat(rank: 6, flat: 'C-412', savings: 1320, energyScore: 72, kw: 2.8),
      Flat(rank: 7, flat: 'A-309', savings: 1210, energyScore: 68, kw: 2.9),
      Flat(rank: 8, flat: 'B-401', savings: 1100, energyScore: 65, kw: 3.1),
    ],
  );
});
