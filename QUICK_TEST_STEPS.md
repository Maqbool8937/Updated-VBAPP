# ⚡ Quick Test Steps

## 🎯 **3-Minute Setup & Test**

### **Step 1: Update Configuration** (30 seconds)

Open `lib/config/api_config.dart` and update:

```dart
// Line 17 - Update to your computer's IP
static const String _serverHost = '192.168.100.60';  // ✅ Already updated!

// Line 21 - Verify port matches your React server
static const String _serverPort = '5000';  // ← Change if different

// Line 37 - Set based on your testing device
static const bool _isAndroidEmulator = false;  // true for emulator, false for physical device
```

### **Step 2: Start React Server** (1 minute)

1. Open your React API project folder
2. Start the server:
   ```bash
   npm start
   # or
   node server.js
   ```
3. Verify it's running on port 5000
4. Test in browser: `http://localhost:5000` (should respond)

### **Step 3: Run Flutter App** (1 minute)

1. **Hot Restart** the app (not just hot reload):
   ```bash
   flutter run
   ```
   Or press `R` in the terminal where Flutter is running

2. **Check Console** - You should see:
   ```
   === API Configuration ===
   Base URL: http://192.168.100.60:5000/api
   ...
   ```

### **Step 4: Test Login** (30 seconds)

1. Enter username: `john.fo.lhr.ctp` (or your test user)
2. Enter password: (your test password)
3. Tap "SIGN IN"

**✅ Success = Navigates to Home Screen**
**❌ Failure = Check console for error message**

---

## 🔍 **Quick Troubleshooting**

| Error | Solution |
|-------|----------|
| Connection timeout | React server not running or wrong IP |
| Cannot connect | Check IP address or set `_isAndroidEmulator = true` |
| 404 Not Found | Verify React server port is 5000 |
| 401 Unauthorized | Wrong username/password |

---

## 📱 **Device-Specific Settings**

### **Android Emulator:**
```dart
static const bool _isAndroidEmulator = true;
static const String _serverHost = '192.168.100.60';  // Can be anything, emulator uses 10.0.2.2
```

### **Physical Android Device:**
```dart
static const bool _isAndroidEmulator = false;
static const String _serverHost = '192.168.100.60';  // Your computer's IP
```

### **iOS Simulator:**
```dart
static const bool _isAndroidEmulator = false;
static const String _serverHost = 'localhost';
```

---

## ✅ **Test Checklist**

- [ ] Updated `_serverHost` to `192.168.100.60`
- [ ] Verified `_serverPort` is `5000`
- [ ] React server is running
- [ ] Tested login successfully
- [ ] Can submit records
- [ ] Records appear in "My Records"

---

**That's it! You're ready to test!** 🚀

