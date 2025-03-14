import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late final Dio dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3000/api',
        // connectTimeout: const Duration(seconds: 5),
        //receiveTimeout: const Duration(seconds: 3),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Add interceptors
    //   dio.interceptors.addAll([
    //     PrettyDioLogger(
    //       requestHeader: true,
    //       requestBody: true,
    //       responseBody: true,
    //       responseHeader: false,
    //       compact: false,
    //     ),
    //     InterceptorsWrapper(
    //       onRequest: (options, handler) {
    //         // Add auth token if available
    //         final token = 'YOUR_AUTH_TOKEN';
    //         if (token != null) {
    //           options.headers['Authorization'] = 'Bearer $token';
    //         }
    //         return handler.next(options);
    //       },
    //       onError: (DioException e, handler) {
    //         // Handle common errors
    //         if (e.type == DioExceptionType.connectionTimeout) {
    //           return handler.reject(
    //             DioException(
    //               requestOptions: e.requestOptions,
    //               error:
    //                   'Connection timeout. Please check your internet connection.',
    //             ),
    //           );
    //         }
    //         return handler.next(e);
    //       },
    //     ),
    //   ]);
  }
}
