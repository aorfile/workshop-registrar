import 'package:dio/dio.dart';
import '../models/workshop_model.dart';
import '../models/registration_model.dart';
import '../controller/api_service.dart';

class WorkshopRepository {
  final Dio _dio = ApiService().dio;
  final String _currentUser = 'aorfile'; // Current user from system
  final DateTime _currentTime = DateTime.parse('2025-03-13 13:46:04'); // System time

  // Get upcoming workshops
  Future<List<Workshop>> getUpcomingWorkshops({
    int? limit,
    int? offset,
    String? category,
  }) async {
    try {
      final response = await _dio.get(
        '/workshops',
        queryParameters: {
          'limit': limit,
          'offset': offset,
          'category': category,
        },
      );

      return (response.data as List)
          .map((json) => Workshop.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Create new workshop
  Future<Workshop> createWorkshop(Workshop workshop) async {
    try {
      final response = await _dio.post(
        '/workshops',
        data: {
          ...workshop.toJson(),
          'created_by': _currentUser,
          'created_at': _currentTime.toIso8601String(),
        },
      );

      return Workshop.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Register for workshop
  Future<Registration> registerForWorkshop(String workshopId) async {
    try {
      final response = await _dio.post(
        '/workshops/$workshopId/register',
        data: {
          'student_id': _currentUser,
          'registered_at': _currentTime.toIso8601String(),
        },
      );

      return Registration.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Get user's workshops
  Future<List<Workshop>> getUserWorkshops() async {
    try {
      final response = await _dio.get('/users/$_currentUser/workshops');
      return (response.data as List)
          .map((json) => Workshop.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Cancel registration
  Future<void> cancelRegistration(String workshopId, {String? reason}) async {
    try {
      await _dio.delete(
        '/workshops/$workshopId/register',
        data: {
          'cancellation_reason': reason,
          'cancelled_at': _currentTime.toIso8601String(),
        },
      );
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