// lib/models/registration_model.dart
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Registration {
  final String registrationId;
  final String studentId;
  final String workshopId;
  final String status;
  final DateTime? attendanceMarkedAt;
  final String? attendanceMarkedBy;
  final int? waitlistPosition;
  final String? cancellationReason;
  final DateTime registeredAt;
  final DateTime updatedAt;

  Registration({
    required this.registrationId,
    required this.studentId,
    required this.workshopId,
    required this.status,
    this.attendanceMarkedAt,
    this.attendanceMarkedBy,
    this.waitlistPosition,
    this.cancellationReason,
    required this.registeredAt,
    required this.updatedAt,
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    registrationId: json['registration_id'],
    studentId: json['student_id'],
    workshopId: json['workshop_id'],
    status: json['status'],
    attendanceMarkedAt: json['attendance_marked_at'] != null 
      ? DateTime.parse(json['attendance_marked_at'])
      : null,
    attendanceMarkedBy: json['attendance_marked_by'],
    waitlistPosition: json['waitlist_position'],
    cancellationReason: json['cancellation_reason'],
    registeredAt: DateTime.parse(json['registered_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'registration_id': registrationId,
    'student_id': studentId,
    'workshop_id': workshopId,
    'status': status,
    'attendance_marked_at': attendanceMarkedAt?.toIso8601String(),
    'attendance_marked_by': attendanceMarkedBy,
    'waitlist_position': waitlistPosition,
    'cancellation_reason': cancellationReason,
    'registered_at': registeredAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}