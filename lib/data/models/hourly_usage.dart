class HourlyUsage {
  final String hour; // e.g., "00:00"
  final double usage; // kWh
  final String tariff; // 'Sasta', 'Mid', 'Peak'
  final double rate; // INR per kWh

  HourlyUsage({required this.hour, required this.usage, required this.tariff, required this.rate});
}
