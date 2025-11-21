import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../models/beggar_record.dart';

class BeggarRecordService {
  late Dio _dio;

  BeggarRecordService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 300), // 5 minutes for file uploads
        receiveTimeout: const Duration(seconds: 300),
        sendTimeout: const Duration(seconds: 300),
      ),
    );

    // Add auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ));
    }
  }

  /// Submit a new beggar record
  Future<Map<String, dynamic>> submitBeggarRecord({
    required String fullName,
    required String gender,
    required String beggaryType,
    required String captureLocation,
    required String policeStation,
    required String place,
    String? cnic,
    String? age,
    String? permanentAddress,
    String? presentAddress,
    String? originDistrict,
    String? linkedMafia,
    String? mafiaDetails,
    String? previousRecord,
    String? additionalNotes,
    String? actionType,
    String? firNo,
    String? firPoliceStation,
    String? organizationName,
    File? photo,
    File? biometric,
  }) async {
    try {
      final formData = FormData.fromMap({
        // Required fields
        'full_name': fullName,
        'gender': gender,
        'beggary_type': beggaryType,
        'capture_datetime': DateTime.now().toIso8601String(),
        'capture_location': captureLocation,
        'police_station': policeStation,
        'place': place,

        // Optional fields
        if (cnic != null && cnic.isNotEmpty) 'cnic': cnic,
        if (age != null && age.isNotEmpty) 'age': age,
        if (permanentAddress != null && permanentAddress.isNotEmpty)
          'permanent_address': permanentAddress,
        if (presentAddress != null && presentAddress.isNotEmpty)
          'present_address': presentAddress,
        if (originDistrict != null && originDistrict.isNotEmpty)
          'origin_district': originDistrict,
        if (linkedMafia != null && linkedMafia.isNotEmpty)
          'linked_mafia': linkedMafia,
        if (mafiaDetails != null && mafiaDetails.isNotEmpty)
          'mafia_details': mafiaDetails,
        if (previousRecord != null && previousRecord.isNotEmpty)
          'previous_record': previousRecord,
        if (additionalNotes != null && additionalNotes.isNotEmpty)
          'additional_notes': additionalNotes,
        if (actionType != null && actionType.isNotEmpty)
          'action_type': actionType,
        if (firNo != null && firNo.isNotEmpty) 'fir_no': firNo,
        if (firPoliceStation != null && firPoliceStation.isNotEmpty)
          'fir_police_station': firPoliceStation,
        if (organizationName != null && organizationName.isNotEmpty)
          'organization_name': organizationName,

        // Files
        if (photo != null)
          'photo': await MultipartFile.fromFile(
            photo.path,
            filename: 'photo.jpg',
          ),
        if (biometric != null)
          'biometric': await MultipartFile.fromFile(
            biometric.path,
            filename: 'biometric.jpg',
          ),
      });

      final response = await _dio.post(
        ApiConfig.submitBeggarRecord,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to submit record');
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to submit record';
      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else {
          errorMessage = 'Server error: ${e.response?.statusCode}';
        }
      } else {
        errorMessage = 'Network error: ${e.message ?? "Unknown error"}';
      }
      throw Exception(errorMessage);
    }
  }

  /// Get all records submitted by the logged-in field officer
  Future<List<BeggarRecord>> getMyRecords() async {
    try {
      final response = await _dio.get(ApiConfig.getMyRecords);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          return data
              .map((json) => BeggarRecord.fromJson(json))
              .toList();
        }
        return [];
      } else {
        throw Exception('Failed to fetch records');
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch records';
      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }
      } else {
        errorMessage = 'Network error: ${e.message ?? "Unknown error"}';
      }
      throw Exception(errorMessage);
    }
  }

  /// Get a single record by ID
  Future<BeggarRecord> getRecordById(String recordId) async {
    try {
      final response = await _dio.get(ApiConfig.getRecordEndpoint(recordId));

      if (response.statusCode == 200) {
        return BeggarRecord.fromJson(response.data);
      } else {
        throw Exception('Record not found');
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch record';
      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }
      } else {
        errorMessage = 'Network error: ${e.message ?? "Unknown error"}';
      }
      throw Exception(errorMessage);
    }
  }

  /// Check if CNIC already exists
  Future<Map<String, dynamic>> checkCNIC(String cnic) async {
    try {
      final response = await _dio.get(ApiConfig.getCheckCNICEndpoint(cnic));

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('CNIC check failed');
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to check CNIC';
      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }
      } else {
        errorMessage = 'Network error: ${e.message ?? "Unknown error"}';
      }
      throw Exception(errorMessage);
    }
  }

  /// Update an existing record
  Future<Map<String, dynamic>> updateRecord({
    required String recordId,
    String? fullName,
    String? gender,
    String? beggaryType,
    String? captureLocation,
    String? policeStation,
    String? place,
    File? photo,
    // Add other optional fields as needed
  }) async {
    try {
      final formData = FormData.fromMap({
        if (fullName != null && fullName.isNotEmpty) 'full_name': fullName,
        if (gender != null && gender.isNotEmpty) 'gender': gender,
        if (beggaryType != null && beggaryType.isNotEmpty)
          'beggary_type': beggaryType,
        if (captureLocation != null && captureLocation.isNotEmpty)
          'capture_location': captureLocation,
        if (policeStation != null && policeStation.isNotEmpty)
          'police_station': policeStation,
        if (place != null && place.isNotEmpty) 'place': place,
        if (photo != null)
          'photo': await MultipartFile.fromFile(
            photo.path,
            filename: 'photo.jpg',
          ),
      });

      final response = await _dio.put(
        ApiConfig.getUpdateRecordEndpoint(recordId),
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update record');
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to update record';
      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }
      } else {
        errorMessage = 'Network error: ${e.message ?? "Unknown error"}';
      }
      throw Exception(errorMessage);
    }
  }

  /// Get hierarchy (districts and departments) - No auth required
  Future<Map<String, dynamic>> getHierarchy() async {
    try {
      final response = await _dio.get(ApiConfig.getHierarchy);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch hierarchy');
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch hierarchy';
      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }
      } else {
        errorMessage = 'Network error: ${e.message ?? "Unknown error"}';
      }
      throw Exception(errorMessage);
    }
  }
}

