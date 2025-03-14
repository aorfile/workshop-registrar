import 'package:frontend/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthResponse {
  final User user;
  final String? token;

  AuthResponse({required this.user, required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    token: json['token'] as String,
  );

  Map<String, dynamic> toJson() => {'user': user.toJson(), 'token': token};
}
