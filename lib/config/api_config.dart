import 'dart:io';
import 'package:flutter/foundation.dart';

/// API Configuration Class
///
/// This class manages all API endpoints and base URLs for your React backend.
/// Update the values below to match your React API server configuration.
class ApiConfig {
  // ============================================
  // API SERVER CONFIGURATION
  // ============================================

  /// Your React API server IP address or domain
  /// Examples:
  /// - Local development: '192.168.100.60' or 'localhost'
  /// - Production: 'your-api-domain.com'
  ///
  /// 💡 TIP: Run 'ipconfig' in terminal to find your computer's IP address
  /// Current detected IP: 192.168.100.60
  static const String _serverHost = '192.168.100.125';

  /// Your React API server port
  /// Common ports: 3000, 5000, 8000, 8080
  static const String _serverPort = '5000';

  /// Use HTTPS (true) or HTTP (false)
  /// Set to true for production, false for local development
  static const bool _useHttps = false;

  /// API base path (if your React API has a base path)
  /// Examples: '/api', '/v1', '/api/v1', or '' for root
  static const String _apiBasePath = '/api';

  // ============================================
  // ENVIRONMENT CONFIGURATION
  // ============================================

  /// Set to true if running on Android Emulator
  /// Android Emulator uses special IP (10.0.2.2) to access host machine
  static const bool _isAndroidEmulator = false;

  // ============================================
  // BASE URL GENERATION
  // ============================================

  /// Get the base URL for API requests
  static String get baseUrl {
    final protocol = _useHttps ? 'https' : 'http';
    String host = _serverHost;

    // Platform-specific host adjustments
    if (kIsWeb) {
      host = 'localhost';
    } else if (Platform.isAndroid && _isAndroidEmulator) {
      // Android Emulator special IP
      host = '10.0.2.2';
    } else if (Platform.isIOS) {
      // iOS Simulator can use localhost
      if (_serverHost == 'localhost' || _serverHost == '127.0.0.1') {
        host = 'localhost';
      }
    }

    final port = _serverPort.isNotEmpty ? ':$_serverPort' : '';
    return '$protocol://$host$port$_apiBasePath';
  }

  // ============================================
  // API ENDPOINTS
  // ============================================

  // Authentication Endpoints
  static const String login = '/auth/login';
  static const String getCurrentUser = '/auth/me';
  static const String forgotPassword = '/auth/forgot-password';

  // Beggar Record Endpoints (Main Functionality)
  static const String submitBeggarRecord = '/beggars/add';
  static const String getMyRecords = '/beggars/all';
  static const String getRecordById =
      '/beggars'; // Use: getRecordById + '/{id}'
  static const String updateRecord =
      '/beggars/update'; // Use: updateRecord + '/{id}'
  static const String checkCNIC =
      '/beggars/check-cnic'; // Use: checkCNIC + '/{cnic}'

  // Configuration/Meta Endpoints
  static const String getHierarchy = '/meta/hierarchy';

  // Image Access (Public)
  static String getImageUrl(String filename) {
    final protocol = _useHttps ? 'https' : 'http';
    String host = _serverHost;
    if (kIsWeb) {
      host = 'localhost';
    } else if (Platform.isAndroid && _isAndroidEmulator) {
      host = '10.0.2.2';
    }
    final port = _serverPort.isNotEmpty ? ':$_serverPort' : '';
    return '$protocol://$host$port/uploads/$filename';
  }

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Get full URL for an endpoint
  static String getEndpoint(String endpoint) {
    // Remove leading slash if present to avoid double slashes
    final cleanEndpoint = endpoint.startsWith('/')
        ? endpoint.substring(1)
        : endpoint;
    return '$baseUrl/$cleanEndpoint';
  }

  /// Get record by ID endpoint
  static String getRecordEndpoint(String recordId) {
    return '$getRecordById/$recordId';
  }

  /// Get update record endpoint
  static String getUpdateRecordEndpoint(String recordId) {
    return '$updateRecord/$recordId';
  }

  /// Get check CNIC endpoint
  static String getCheckCNICEndpoint(String cnic) {
    return '$checkCNIC/$cnic';
  }

  /// Print current configuration (for debugging)
  static void printConfig() {
    if (kDebugMode) {
      print('=== API Configuration ===');
      print('Base URL: $baseUrl');
      print('Server Host: $_serverHost');
      print('Server Port: $_serverPort');
      print('Use HTTPS: $_useHttps');
      print('API Base Path: $_apiBasePath');
      print('Is Android Emulator: $_isAndroidEmulator');
      print('========================');
    }
  }
}
