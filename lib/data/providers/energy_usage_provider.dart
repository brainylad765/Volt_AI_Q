import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hourly_usage.dart';
import '../models/weekly_usage.dart';
import '../models/schedule_item.dart';

final hourlyUsageProvider = Provider<List<HourlyUsage>>((ref) {
  // Generate 24 hours of data similar to React
  List<HourlyUsage> data = [];
  for (int i = 0; i < 24; i++) {
    bool isPeak = (i >= 10 && i <= 14) || (i >= 18 && i <= 22);
    bool isMid = (i >= 6 && i <= 10) || (i >= 14 && i <= 18);
    double base = isPeak ? 1.8 + (i % 10) * 0.08 : isMid ? 1.0 + (i % 10) * 0.05 : 0.3 + (i % 10) * 0.03;
    double usage = (base * 100).round() / 100;
    String tariff = isPeak ? 'Peak' : isMid ? 'Mid' : 'Sasta';
    double rate = isPeak ? 8.5 : isMid ? 5.2 : 3.1;
    data.add(HourlyUsage(
      hour: '${i.toString().padLeft(2, '0')}:00',
      usage: usage,
      tariff: tariff,
      rate: rate,
    ));
  }
  return data;
});

final weeklyUsageProvider = Provider<List<WeeklyUsage>>((ref) {
  return [
    WeeklyUsage(day: 'Mon', usage: 12.4, target: 10, cost: 86),
    WeeklyUsage(day: 'Tue', usage: 10.8, target: 10, cost: 72),
    WeeklyUsage(day: 'Wed', usage: 14.2, target: 10, cost: 105),
    WeeklyUsage(day: 'Thu', usage: 9.6, target: 10, cost: 64),
    WeeklyUsage(day: 'Fri', usage: 11.1, target: 10, cost: 78),
    WeeklyUsage(day: 'Sat', usage: 15.8, target: 10, cost: 118),
    WeeklyUsage(day: 'Sun', usage: 13.5, target: 10, cost: 96),
  ];
});

final scheduleProvider = Provider<List<ScheduleItem>>((ref) {
  return [
    ScheduleItem(time: '05:30 AM', appliance: 'Geyser', duration: '30 min', status: 'completed', tariff: 'sasta', saved: 14),
    ScheduleItem(time: '06:00 AM', appliance: 'Washing Machine', duration: '45 min', status: 'completed', tariff: 'sasta', saved: 8),
    ScheduleItem(time: '07:00 AM', appliance: 'Iron', duration: '20 min', status: 'completed', tariff: 'mid', saved: 0),
    ScheduleItem(time: '09:00 AM', appliance: 'AC', duration: '3 hrs', status: 'active', tariff: 'mid', saved: 0),
    ScheduleItem(time: '02:00 PM', appliance: 'AC', duration: '4 hrs', status: 'scheduled', tariff: 'peak', saved: 0),
    ScheduleItem(time: '05:00 PM', appliance: 'Geyser', duration: '20 min', status: 'scheduled', tariff: 'mid', saved: 6),
    ScheduleItem(time: '09:00 PM', appliance: 'Dishwasher', duration: '1 hr', status: 'optimized', tariff: 'sasta', saved: 12),
    ScheduleItem(time: '10:00 PM', appliance: 'EV Charging', duration: '4 hrs', status: 'optimized', tariff: 'sasta', saved: 32),
  ];
});
