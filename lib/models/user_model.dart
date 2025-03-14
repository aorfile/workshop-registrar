// lib/models/user_model.dart
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? studentId;
  final String? googleId;
  final String? role;
  final String? profilePictureUrl;
  final String? password;
  final String? department;
  final bool? emailVerified;
  final bool? phoneVerified;

  final Map<String, dynamic>? preferences;
  final String? status;

  User({
    this.userId,
    this.fullName,
    this.email,
    this.phone,
    this.googleId,
    this.profilePictureUrl,
    this.studentId,
    this.role,
    this.password,
    this.department,

    this.emailVerified = false,
    this.phoneVerified = false,
    this.preferences = const {},
    this.status = 'active',
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['user_id'],
    fullName: json['full_name'],
    email: json['email'],
    phone: json['phone'],

    password: json['password'],
    role: json['role'],
    googleId: json['google_id'],
    profilePictureUrl: json['profile_picture_url'],
    studentId: json['student_id'],
    department: json['department'],
    emailVerified: json['email_verified'],
    phoneVerified: json['phone_verified'],
    preferences: json['preferences'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'full_name': fullName,
    'email': email,
    'phone': phone,
    'role': role,
    'department': department,
    'email_verified': emailVerified,
    'phone_verified': phoneVerified,
    'preferences': preferences,
    'status': status,
    'profile_picture_url': profilePictureUrl,
    'student_id': studentId,
    'password': password,
  };
}
