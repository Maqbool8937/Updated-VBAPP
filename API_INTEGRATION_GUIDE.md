# 🔌 React API Integration Guide

This guide will help you integrate your React backend APIs with the Flutter mobile app.

---

## 📋 **Quick Setup**

### Step 1: Configure Your API Server Details

Open `lib/config/api_config.dart` and update these values:

```dart
// Your React API server IP or domain
static const String _serverHost = '192.168.1.100';  // Change this

// Your React API server port
static const String _serverPort = '5000';  // Change this

// Use HTTPS for production, HTTP for development
static const bool _useHttps = false;  // Set to true for production

// API base path (usually '/api' or '/api/v1')
static const String _apiBasePath = '/api';  // Change if different

// Set to true if using Android Emulator
static const bool _isAndroidEmulator = false;
```

### Step 2: Verify Your React API Endpoints

Make sure your React API has these endpoints:

#### Authentication Endpoints
- `POST /api/auth/login` - User login
- `POST /api/auth/forgot-password` - Password reset
- `POST /api/auth/logout` - User logout (optional)

#### Case Management Endpoints
- `POST /api/cases` - Submit new case
- `GET /api/cases/assigned` - Get assigned cases
- `GET /api/cases/search?q={query}` - Search cases
- `GET /api/cases/{id}` - Get case by ID

---

## 🔧 **API Endpoint Configuration**

### Current Endpoints in `api_config.dart`:

```dart
// Authentication
POST /api/auth/login
POST /api/auth/forgot-password
GET  /api/user/me

// Cases
POST /api/cases
GET  /api/cases/assigned
GET  /api/cases/search
GET  /api/cases/{id}
```

### To Add New Endpoints:

1. Add the endpoint constant in `lib/config/api_config.dart`:
```dart
static const String yourNewEndpoint = '/your-endpoint';
```

2. Use it in your service:
```dart
final response = await _dio.get(ApiConfig.yourNewEndpoint);
```

---

## 📡 **API Request/Response Format**

### Login Request Format

Your React API should accept:
```json
POST /api/auth/login
{
  "username": "user123",
  "password": "password123"
}
```

Expected Response:
```json
{
  "token": "jwt_token_here",
  "user": {
    "id": "123",
    "username": "user123",
    "email": "user@example.com",
    "name": "User Name"
  }
}
```

### Case Submission Format

Your React API should accept:
```json
POST /api/cases
Content-Type: multipart/form-data

Fields:
- name: string
- gender: string
- age: string
- clothing: string
- behavioral_notes: string
- officer_notes: string
- latitude: number
- longitude: number
- address: string
- shelter_id: string (optional)
- face_image: File (optional)
- photos: File[] (multiple files)
```

Expected Response:
```json
{
  "id": "case_id",
  "message": "Case submitted successfully",
  "status": "success"
}
```

### Get Assigned Cases Response

Expected Response:
```json
[
  {
    "id": "case_id",
    "name": "Person Name",
    "gender": "male",
    "age": "30",
    "address": "123 Main St",
    "created_at": "2024-01-15T10:30:00Z"
  }
]
```

---

## 🔐 **Authentication**

The app uses **Bearer Token** authentication:

1. Token is stored in SharedPreferences after login
2. Token is automatically added to all requests via interceptor
3. Token format: `Authorization: Bearer {token}`

### Token Storage
- Token is saved after successful login
- Token is removed on logout
- Token is automatically included in all authenticated requests

---

## 🌐 **Network Configuration**

### For Android Emulator:
```dart
static const bool _isAndroidEmulator = true;
```
Uses `http://10.0.2.2:5000` to access your localhost

### For Physical Android Device:
```dart
static const bool _isAndroidEmulator = false;
static const String _serverHost = '192.168.1.100';  // Your computer's IP
```
Uses your computer's IP address on the same network

### For iOS Simulator:
Uses `http://localhost:5000`

### For Production:
```dart
static const String _serverHost = 'your-api-domain.com';
static const String _serverPort = '443';  // or your port
static const bool _useHttps = true;
static const String _apiBasePath = '/api';
```

---

## 🧪 **Testing Your Integration**

### 1. Test Login
```dart
final authService = AuthService();
try {
  final result = await authService.login('username', 'password');
  print('Login successful: ${result['user']}');
} catch (e) {
  print('Login failed: $e');
}
```

### 2. Test Case Submission
```dart
final caseService = CaseService();
try {
  final result = await caseService.submitCase(
    biometricData: {...},
    personalInfo: {...},
    locationData: {...},
    images: [...],
    officerNotes: 'Notes here',
  );
  print('Case submitted: $result');
} catch (e) {
  print('Submission failed: $e');
}
```

### 3. Check API Logs
The app logs all API requests in debug mode. Check your console for:
- Request URL
- Request body
- Response data
- Error messages

---

## 🐛 **Troubleshooting**

### Issue: Connection Timeout
**Solution:**
- Check if your React server is running
- Verify the IP address and port
- Check firewall settings
- Ensure device/emulator is on the same network

### Issue: 401 Unauthorized
**Solution:**
- Check if token is being sent: Look for `Authorization` header in logs
- Verify token format in your React API
- Check if token has expired

### Issue: 404 Not Found
**Solution:**
- Verify endpoint paths match your React API
- Check `_apiBasePath` in `api_config.dart`
- Ensure your React API routes are correct

### Issue: CORS Errors (Web only)
**Solution:**
- Add CORS headers in your React API:
```javascript
app.use(cors({
  origin: '*',  // or specific origin
  credentials: true
}));
```

### Issue: Image Upload Fails
**Solution:**
- Check if your React API accepts `multipart/form-data`
- Verify file size limits
- Check file field names match (`photos`, `face_image`)

---

## 📝 **Customizing Endpoints**

If your React API uses different endpoint names, update `api_config.dart`:

```dart
// Example: If your login endpoint is different
static const String login = '/users/login';  // Instead of '/auth/login'
```

---

## 🔄 **Updating API Configuration**

After changing `api_config.dart`:
1. Save the file
2. Hot restart your app (not hot reload)
3. Check console for API configuration printout

---

## 📚 **Additional Resources**

- [Dio HTTP Client Documentation](https://pub.dev/packages/dio)
- [Flutter Network Security Config](https://docs.flutter.dev/deployment/android#network-security-config)

---

## ✅ **Checklist**

Before deploying:
- [ ] Update `_serverHost` with your production domain
- [ ] Set `_useHttps = true` for production
- [ ] Verify all endpoints match your React API
- [ ] Test all API calls
- [ ] Check error handling
- [ ] Verify authentication flow
- [ ] Test image uploads
- [ ] Check network security config for Android

---

**Need Help?** Check the console logs - all API requests and responses are logged in debug mode!

