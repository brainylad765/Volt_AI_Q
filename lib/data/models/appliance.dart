class Appliance {
  final String id;
  final String name;
  final String category;
  final double kw; // power in kW
  final int dailyHours; // average hours per day
  final double monthlyCost; // in INR
  final bool isOn;
  final bool smartEnabled;
  final String? schedule; // e.g., "10:00 AM - 2:00 PM"
  final String iconName; // name of icon from Lucide (we'll map to Flutter icons)

  Appliance({
    required this.id,
    required this.name,
    required this.category,
    required this.kw,
    required this.dailyHours,
    required this.monthlyCost,
    required this.isOn,
    required this.smartEnabled,
    this.schedule,
    required this.iconName,
  });

  Appliance copyWith({
    String? id,
    String? name,
    String? category,
    double? kw,
    int? dailyHours,
    double? monthlyCost,
    bool? isOn,
    bool? smartEnabled,
    String? schedule,
    String? iconName,
  }) {
    return Appliance(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      kw: kw ?? this.kw,
      dailyHours: dailyHours ?? this.dailyHours,
      monthlyCost: monthlyCost ?? this.monthlyCost,
      isOn: isOn ?? this.isOn,
      smartEnabled: smartEnabled ?? this.smartEnabled,
      schedule: schedule ?? this.schedule,
      iconName: iconName ?? this.iconName,
    );
  }
}
