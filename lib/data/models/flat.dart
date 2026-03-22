class Flat {
  final int rank;
  final String flat;
  final double savings; // in INR
  final int energyScore; // 0-100
  final double kw; // current load in kW

  Flat({
    required this.rank,
    required this.flat,
    required this.savings,
    required this.energyScore,
    required this.kw,
  });
}
