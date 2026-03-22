import 'flat.dart';
import 'tariff_mode.dart';

class ColonyData {
  final double totalKW;
  final int totalHomes;
  final double totalSaving;
  final TariffMode tariff;
  final List<Flat> flats;

  ColonyData({
    required this.totalKW,
    required this.totalHomes,
    required this.totalSaving,
    required this.tariff,
    required this.flats,
  });

  ColonyData copyWith({
    double? totalKW,
    int? totalHomes,
    double? totalSaving,
    TariffMode? tariff,
    List<Flat>? flats,
  }) {
    return ColonyData(
      totalKW: totalKW ?? this.totalKW,
      totalHomes: totalHomes ?? this.totalHomes,
      totalSaving: totalSaving ?? this.totalSaving,
      tariff: tariff ?? this.tariff,
      flats: flats ?? this.flats,
    );
  }
}

final defaultColonyData = ColonyData(
  totalKW: 142.7,
  totalHomes: 200,
  totalSaving: 41200,
  tariff: TariffMode.mid,
  flats: [
    Flat(rank: 1, flat: 'A-301', savings: 1240, energyScore: 94, kw: 0.52),
    Flat(rank: 2, flat: 'B-108', savings: 1180, energyScore: 91, kw: 0.61),
    Flat(rank: 3, flat: 'C-205', savings: 1090, energyScore: 88, kw: 0.68),
    Flat(rank: 4, flat: 'D-412', savings: 980, energyScore: 85, kw: 0.73),
    Flat(rank: 5, flat: 'A-104', savings: 920, energyScore: 82, kw: 0.79),
    Flat(rank: 6, flat: 'B-310', savings: 870, energyScore: 79, kw: 0.84),
    Flat(rank: 7, flat: 'C-407', savings: 810, energyScore: 76, kw: 0.91),
    Flat(rank: 8, flat: 'D-202', savings: 760, energyScore: 73, kw: 0.95),
    Flat(rank: 9, flat: 'A-506', savings: 710, energyScore: 71, kw: 1.02),
    Flat(rank: 10, flat: 'B-201', savings: 650, energyScore: 68, kw: 1.08),
  ],
);
