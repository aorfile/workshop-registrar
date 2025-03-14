// lib/models/attendance_model.dart
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Attendance {
  final String attendanceId;
  final String registrationId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final String attendanceStatus;
  final String markedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Attendance({
    required this.attendanceId,
    required this.registrationId,
    required this.checkInTime,
    this.checkOutTime,
    required this.attendanceStatus,
    required this.markedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    attendanceId: json['attendance_id'],
    registrationId: json['registration_id'],
    checkInTime: DateTime.parse(json['check_in_time']),
    checkOutTime:
        json['check_out_time'] != null
            ? DateTime.parse(json['check_out_time'])
            : null,
    attendanceStatus: json['attendance_status'],
    markedBy: json['marked_by'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'attendance_id': attendanceId,
    'registration_id': registrationId,
    'check_in_time': checkInTime.toIso8601String(),
    'check_out_time': checkOutTime?.toIso8601String(),
    'attendance_status': attendanceStatus,
    'marked_by': markedBy,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
