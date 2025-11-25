import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';

class ChangePasswordService {
  static Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final url = ApiConfig.getEndpoint(ApiConfig.changePassword);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        }),
      );

      return {
        "success": response.statusCode == 200,
        "data": jsonDecode(response.body),
      };
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }
}
