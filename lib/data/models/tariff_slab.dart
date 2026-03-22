class TariffSlab {
  final String range;
  final double rate;
  final String type; // 'sasta', 'mid', 'peak'

  TariffSlab({required this.range, required this.rate, required this.type});
}
