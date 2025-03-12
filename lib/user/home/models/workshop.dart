class Workshop {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final int duration; // in minutes
  final int capacity;
  final int enrolledCount;

  Workshop({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.duration,
    required this.capacity,
    this.enrolledCount = 0,
  });
}