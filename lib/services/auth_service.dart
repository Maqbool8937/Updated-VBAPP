import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.1.100:5000';

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'username': username, 'password': password}),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['token'] == null || data['user'] == null) {
          throw Exception('Invalid server response');
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('user', jsonEncode(data['user']));

        return data;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Cannot connect to server. Error: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }
}




// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   static const String baseUrl =
//       'http://192.168.1.100:5000'; 

//   Future<Map<String, dynamic>> login(String username, String password) async {
//     try {
//       final response = await http
//           .post(
//             Uri.parse('$baseUrl/api/auth/login'),
//             headers: {'Content-Type': 'application/json'},
//             body: jsonEncode({'username': username, 'password': password}),
//           )
//           .timeout(const Duration(seconds: 10));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', data['token'] ?? '');
//         await prefs.setString('user', jsonEncode(data['user'] ?? {}));
//         return data;
//       } else {
//         final error = jsonDecode(response.body);
//         throw Exception(error['message'] ?? 'Login failed');
//       }
//     } catch (e) {
//       throw Exception('Login error: $e');
//     }
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//     await prefs.remove('user');
//   }
// }







// lhr.fo.lhr.ctp
// Punjab12