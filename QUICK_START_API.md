# 🚀 Quick Start: React API Integration

## ⚡ **3-Step Setup**

### Step 1: Open `lib/config/api_config.dart`

### Step 2: Update These 4 Values:

```dart
// 1. Your React API server IP or domain
static const String _serverHost = '192.168.1.100';  // ← Change this

// 2. Your React API server port  
static const String _serverPort = '5000';  // ← Change this

// 3. Use HTTPS? (true for production, false for development)
static const bool _useHttps = false;  // ← Change this

// 4. Android Emulator? (true if using Android Emulator)
static const bool _isAndroidEmulator = false;  // ← Change this
```

### Step 3: Save and Run!

That's it! Your app will now connect to your React API.

---

## 📍 **Common Configurations**

### Local Development (React on localhost:5000)
```dart
_serverHost = '192.168.1.100';  // Your computer's IP
_serverPort = '5000';
_useHttps = false;
_isAndroidEmulator = false;  // true if using emulator
```

### Production (React on yourdomain.com)
```dart
_serverHost = 'your-api-domain.com';
_serverPort = '443';  // or your port
_useHttps = true;
_isAndroidEmulator = false;
```

### Android Emulator
```dart
_serverHost = '192.168.1.100';
_serverPort = '5000';
_useHttps = false;
_isAndroidEmulator = true;  // ← Set to true
```

---

## ✅ **Verify It's Working**

1. Run your app
2. Check console logs - you should see:
   ```
   === API Configuration ===
   Base URL: http://192.168.1.100:5000/api
   ...
   ```

3. Try logging in - if it works, integration is successful!

---

## 🔍 **Need More Details?**

See `API_INTEGRATION_GUIDE.md` for complete documentation.

