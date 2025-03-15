import 'package:flutter/material.dart';
import 'package:frontend/constants/assets.dart';

class Workshop {
  final String workshopId;
  final String title;
  final String? description;
  final DateTime workshopDate;
  final DateTime endTime;
  final String location;
  final String locationType;
  final String? meetingLink;
  final int capacity;
  final int currentRegistrations;
  final int? minParticipants;
  final String status;
  final String category;
  final String? prerequisites;
  final String? materialsUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? imageUrl;
  final List<String>? galleryImages;

  // Computed properties
  Duration get duration => endTime.difference(workshopDate);
  
  String get durationFormatted {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}h${minutes > 0 ? ' ${minutes}m' : ''}';
  }

  int get spotsLeft => capacity - currentRegistrations;
  bool get isUpcoming => workshopDate.isAfter(DateTime.now());
  
  // Location type checks
  bool get isVirtual => locationType == 'virtual';
  bool get isPhysical => locationType == 'physical';
  bool get isHybrid => locationType == 'hybrid';

  // Status checks
  bool get isScheduled => status == 'scheduled';
  bool get isInProgress => status == 'in-progress';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';

  // UI helper getters
  String get backgroundImage => imageUrl ?? AppAssets.getCategoryImage(category);
  
  String get statusDisplay {
    switch (status) {
      case 'scheduled':
        return 'Upcoming';
      case 'in-progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  Color getStatusColor(ThemeData theme) {
    switch (status) {
      case 'scheduled':
        return theme.colorScheme.primary;
      case 'in-progress':
        return theme.colorScheme.secondary;
      case 'completed':
        return Colors.grey;
      case 'cancelled':
        return theme.colorScheme.error;
      default:
        return Colors.grey;
    }
  }

  const Workshop({
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
    required this.category,
    this.prerequisites,
    this.materialsUrl,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
    this.galleryImages,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      workshopId: json['workshop_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      workshopDate: DateTime.parse(json['workshop_date'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      location: json['location'] as String,
      locationType: json['location_type'] as String? ?? 'physical',
      meetingLink: json['meeting_link'] as String?,
      capacity: json['capacity'] as int,
      currentRegistrations: json['current_registrations'] as int? ?? 0,
      minParticipants: json['min_participants'] as int?,
      status: json['status'] as String? ?? 'scheduled',
      category: json['category'] as String,
      prerequisites: json['prerequisites'] as String?,
      materialsUrl: json['materials_url'] as String?,
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      imageUrl: json['image_url'] as String?,
      galleryImages: (json['gallery_images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'image_url': imageUrl,
      'gallery_images': galleryImages,
    };
  }

  Workshop copyWith({
    String? workshopId,
    String? title,
    String? description,
    DateTime? workshopDate,
    DateTime? endTime,
    String? location,
    String? locationType,
    String? meetingLink,
    int? capacity,
    int? currentRegistrations,
    int? minParticipants,
    String? status,
    String? category,
    String? prerequisites,
    String? materialsUrl,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
    List<String>? galleryImages,
  }) {
    return Workshop(
      workshopId: workshopId ?? this.workshopId,
      title: title ?? this.title,
      description: description ?? this.description,
      workshopDate: workshopDate ?? this.workshopDate,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      locationType: locationType ?? this.locationType,
      meetingLink: meetingLink ?? this.meetingLink,
      capacity: capacity ?? this.capacity,
      currentRegistrations: currentRegistrations ?? this.currentRegistrations,
      minParticipants: minParticipants ?? this.minParticipants,
      status: status ?? this.status,
      category: category ?? this.category,
      prerequisites: prerequisites ?? this.prerequisites,
      materialsUrl: materialsUrl ?? this.materialsUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      galleryImages: galleryImages ?? this.galleryImages,
    );
  }
}