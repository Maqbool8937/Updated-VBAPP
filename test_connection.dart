// Quick connection test script
// Run this with: dart test_connection.dart

import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  print('🧪 Testing React API Connection...\n');
  
  // Update these to match your setup
  final serverIp = '192.168.100.60';
  final serverPort = '5000';
  final baseUrl = 'http://$serverIp:$serverPort';
  
  print('Testing connection to: $baseUrl\n');
  
  // Test 1: Check if server is reachable
  print('1️⃣ Testing server connectivity...');
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/api/meta/hierarchy'),
    ).timeout(Duration(seconds: 5));
    
    if (response.statusCode == 200) {
      print('   ✅ Server is reachable!\n');
    } else {
      print('   ⚠️  Server responded with status: ${response.statusCode}\n');
    }
  } catch (e) {
    print('   ❌ Cannot connect to server: $e\n');
    print('   💡 Troubleshooting:');
    print('      - Is your React server running?');
    print('      - Is the IP address correct?');
    print('      - Is the port correct?');
    print('      - Check firewall settings\n');
    exit(1);
  }
  
  // Test 2: Check login endpoint
  print('2️⃣ Testing login endpoint...');
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: '{"username":"test","password":"test"}',
    ).timeout(Duration(seconds: 5));
    
    if (response.statusCode == 401 || response.statusCode == 400) {
      print('   ✅ Login endpoint exists (authentication failed as expected)\n');
    } else if (response.statusCode == 200) {
      print('   ✅ Login endpoint works!\n');
    } else {
      print('   ⚠️  Unexpected status: ${response.statusCode}\n');
    }
  } catch (e) {
    print('   ❌ Login endpoint error: $e\n');
  }
  
  // Test 3: Check uploads folder
  print('3️⃣ Testing image uploads endpoint...');
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/uploads/test.jpg'),
    ).timeout(Duration(seconds: 5));
    
    if (response.statusCode == 404) {
      print('   ✅ Uploads endpoint exists (file not found is expected)\n');
    } else if (response.statusCode == 200) {
      print('   ✅ Uploads endpoint works!\n');
    } else {
      print('   ⚠️  Status: ${response.statusCode}\n');
    }
  } catch (e) {
    print('   ⚠️  Uploads endpoint: $e\n');
  }
  
  print('✅ Connection test complete!');
  print('\n📱 Next step: Run your Flutter app and test login');
}

