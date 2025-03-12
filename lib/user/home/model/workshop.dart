class Workshop {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final int totalSeats;
  final int remainingSeats;
  final String instructor;
  final List<String> topics;
  final String location;
  final String category;
  final DateTime createdAt;
  final bool isRegistered;

  const Workshop({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.totalSeats,
    required this.remainingSeats,
    required this.instructor,
    required this.topics,
    required this.location,
    required this.category,
    required this.createdAt,
    this.isRegistered = false,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      totalSeats: json['totalSeats'] as int,
      remainingSeats: json['remainingSeats'] as int,
      instructor: json['instructor'] as String,
      topics: List<String>.from(json['topics'] as List),
      location: json['location'] as String,
      category: json['category'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRegistered: json['isRegistered'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'totalSeats': totalSeats,
      'remainingSeats': remainingSeats,
      'instructor': instructor,
      'topics': topics,
      'location': location,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'isRegistered': isRegistered,
    };
  }

  Workshop copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? time,
    int? totalSeats,
    int? remainingSeats,
    String? instructor,
    List<String>? topics,
    String? location,
    String? category,
    DateTime? createdAt,
    bool? isRegistered,
  }) {
    return Workshop(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      totalSeats: totalSeats ?? this.totalSeats,
      remainingSeats: remainingSeats ?? this.remainingSeats,
      instructor: instructor ?? this.instructor,
      topics: topics ?? this.topics,
      location: location ?? this.location,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }
}