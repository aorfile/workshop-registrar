// lib/models/notification_model.dart
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Notification {
  final String notificationId;
  final String userId;
  final String type;
  final String message;
  final bool isRead;
  final bool isSent;
  final int sendAttemptCount;
  final DateTime? lastSendAttempt;
  final DateTime? scheduledFor;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notification({
    required this.notificationId,
    required this.userId,
    required this.type,
    required this.message,
    this.isRead = false,
    this.isSent = false,
    this.sendAttemptCount = 0,
    this.lastSendAttempt,
    this.scheduledFor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    notificationId: json['notification_id'],
    userId: json['user_id'],
    type: json['type'],
    message: json['message'],
    isRead: json['is_read'],
    isSent: json['is_sent'],
    sendAttemptCount: json['send_attempt_count'],
    lastSendAttempt:
        json['last_send_attempt'] != null
            ? DateTime.parse(json['last_send_attempt'])
            : null,
    scheduledFor:
        json['scheduled_for'] != null
            ? DateTime.parse(json['scheduled_for'])
            : null,
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'notification_id': notificationId,
    'user_id': userId,
    'type': type,
    'message': message,
    'is_read': isRead,
    'is_sent': isSent,
    'send_attempt_count': sendAttemptCount,
    'last_send_attempt': lastSendAttempt?.toIso8601String(),
    'scheduled_for': scheduledFor?.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
