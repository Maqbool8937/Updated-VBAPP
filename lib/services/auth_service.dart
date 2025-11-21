import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';

class AuthService {
  // Base URL is now managed by ApiConfig
  static String get baseUrl => ApiConfig.baseUrl;
  
  late Dio _dio;

  AuthService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    // Add interceptors for logging (optional, useful for debugging)
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (object) {
        if (kDebugMode) {
          print(object);
        }
      },
    ));
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        ApiConfig.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['token'] == null || data['user'] == null) {
          throw Exception('Invalid server response');
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('user', jsonEncode(data['user']));

        return data;
      } else {
        throw Exception('Login failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle specific Dio exceptions
      String errorMessage;
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        errorMessage = 'Connection timeout after 30 seconds.\n\n'
            'Please check:\n'
            '1. Server is running at $baseUrl\n'
            '2. Device/Emulator is on the same network\n'
            '3. Firewall is not blocking the connection';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'Cannot connect to server at $baseUrl\n\n'
            'Troubleshooting:\n'
            '• Android Emulator: Use http://10.0.2.2:5000\n'
            '• Physical Device: Use your computer\'s IP (e.g., http://192.168.100.125:5000)\n'
            '• iOS Simulator: Use http://localhost:5000\n'
            '• Ensure server is running and accessible';
      } else if (e.response != null) {
        // Server responded with error status
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else {
          errorMessage = 'Login failed with status code: ${e.response?.statusCode}';
        }
      } else {
        errorMessage = 'Network error: ${e.message ?? "Unknown error"}\n\n'
            'Server URL: $baseUrl';
      }
      
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await _dio.post(
        ApiConfig.forgotPassword,
        data: {'email': email},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send reset link');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('message')) {
          throw Exception(errorData['message']);
        }
      }
      throw Exception('Network error: ${e.message ?? "Unknown error"}');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiConfig.getCurrentUser);
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Token expired, clear it
        await logout();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}







// lhr.fo.lhr.ctp
// Punjab12