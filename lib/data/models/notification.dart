class AppNotification {
  final String id;
  final String type; // 'alert', 'saving', 'info'
  final String title;
  final String message;
  final String time;
  final bool read;

  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    required this.read,
  });

  AppNotification copyWith({bool? read}) {
    return AppNotification(
      id: id,
      type: type,
      title: title,
      message: message,
      time: time,
      read: read ?? this.read,
    );
  }
}