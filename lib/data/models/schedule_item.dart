class ScheduleItem {
  final String time;
  final String appliance;
  final String duration;
  final String status; // 'completed', 'active', 'scheduled', 'optimized'
  final String tariff; // 'sasta', 'mid', 'peak'
  final double saved; // in INR

  ScheduleItem({
    required this.time,
    required this.appliance,
    required this.duration,
    required this.status,
    required this.tariff,
    required this.saved,
  });
}
