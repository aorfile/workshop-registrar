import 'package:dio/dio.dart';
import 'package:frontend/models/auth_response.dart';
import '../models/user_model.dart';
import '../controller/api_service.dart';

class UserRepository {
  final Dio _dio = ApiService().dio;

  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get('/users/me');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthResponse> loginUser(User user) async {
    try {
      final response = await _dio.post('/login', data: user);
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthResponse> registerUser(User user) async {
    try {
      final response = await _dio.post('/register', data: user.toJson());
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthResponse> googleLogin(User user) async {
    try {
      final response = await _dio.post('/google');
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post('/logout');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<User> updateUserProfile(User user) async {
    try {
      final response = await _dio.post('/users/me', data: user.toJson());
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Network timeout. Please check your connection.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Unknown error occurred';
        return Exception('Error $statusCode: $message');
      default:
        return Exception('An unexpected error occurred');
    }
  }
}
