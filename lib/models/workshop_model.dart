import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Workshop {
  final String workshopId;
  final String title;
  final String? description;
  final DateTime workshopDate;
  final DateTime endTime;
  final String location;
  final String? locationType;
  final String? meetingLink;
  final int capacity;
  final int currentRegistrations;
  final int? minParticipants;
  final String status;
  final String? category;
  final String? prerequisites;
  final String? materialsUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Computed properties
  Duration get duration => endTime.difference(workshopDate);
  String get durationFormatted {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  int get spotsLeft => capacity - currentRegistrations;
  bool get isUpcoming => workshopDate.isAfter(DateTime.now());

  Workshop({
    required this.workshopId,
    required this.title,
    this.description,
    required this.workshopDate,
    required this.endTime,
    required this.location,
    this.locationType = 'physical',
    this.meetingLink,
    required this.capacity,
    this.currentRegistrations = 0,
    this.minParticipants = 1,
    this.status = 'scheduled',
    this.category,
    this.prerequisites,
    this.materialsUrl,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) => Workshop(
    workshopId: json['workshop_id'],
    title: json['title'],
    description: json['description'],
    workshopDate: DateTime.parse(json['workshop_date']),
    endTime: DateTime.parse(json['end_time']),
    location: json['location'],
    locationType: json['location_type'],
    meetingLink: json['meeting_link'],
    capacity: json['capacity'],
    currentRegistrations: json['current_registrations'] ?? 0,
    minParticipants: json['min_participants'],
    status: json['status'] ?? 'scheduled',
    category: json['category'],
    prerequisites: json['prerequisites'],
    materialsUrl: json['materials_url'],
    createdBy: json['created_by'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'workshop_id': workshopId,
    'title': title,
    'description': description,
    'workshop_date': workshopDate.toIso8601String(),
    'end_time': endTime.toIso8601String(),
    'location': location,
    'location_type': locationType,
    'meeting_link': meetingLink,
    'capacity': capacity,
    'current_registrations': currentRegistrations,
    'min_participants': minParticipants,
    'status': status,
    'category': category,
    'prerequisites': prerequisites,
    'materials_url': materialsUrl,
    'created_by': createdBy,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
