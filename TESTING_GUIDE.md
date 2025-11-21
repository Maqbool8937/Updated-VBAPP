# 🧪 Testing Guide - React API Integration

## Step-by-Step Testing Instructions

---

## 📋 **Step 1: Update API Configuration**

### Current Settings:
- **Server IP**: `192.168.1.100` (needs update)
- **Server Port**: `5000` (verify this matches your React server)
- **Your Computer IP**: `192.168.100.60` (from ipconfig)

### Action Required:

1. **Open** `lib/config/api_config.dart`

2. **Update Line 17** - Change server IP:
   ```dart
   static const String _serverHost = '192.168.100.60';  // ← Your actual IP
   ```

3. **Verify Line 21** - Check if port matches your React server:
   ```dart
   static const String _serverPort = '5000';  // ← Verify this matches your React server
   ```

4. **Set Line 37** - If using Android Emulator:
   ```dart
   static const bool _isAndroidEmulator = true;  // ← Set to true if using emulator
   ```

---

## 🔍 **Step 2: Verify Your React Server**

### Check if React Server is Running:

1. **Open your React API project**
2. **Start the server** (usually `npm start` or `node server.js`)
3. **Verify it's running on port 5000**
4. **Test in browser**: Open `http://localhost:5000/api/auth/login` (should show error, but confirms server is running)

### Common React Server Commands:
```bash
# If using Express/Node.js
npm start
# or
node server.js

# If using React with backend
npm run dev
```

---

## 📱 **Step 3: Test Connection**

### Option A: Using Android Emulator

1. **Set in `api_config.dart`**:
   ```dart
   static const bool _isAndroidEmulator = true;
   ```
   This will use `http://10.0.2.2:5000` to access your localhost

2. **Run your React server** on `localhost:5000`

3. **Run Flutter app**:
   ```bash
   flutter run
   ```

### Option B: Using Physical Android Device

1. **Set in `api_config.dart`**:
   ```dart
   static const bool _isAndroidEmulator = false;
   static const String _serverHost = '192.168.100.60';  // Your computer's IP
   ```

2. **Ensure device and computer are on same Wi-Fi network**

3. **Run your React server** on `0.0.0.0:5000` (to accept external connections):
   ```javascript
   // In your React server code
   app.listen(5000, '0.0.0.0', () => {
     console.log('Server running on http://0.0.0.0:5000');
   });
   ```

4. **Run Flutter app** on physical device

### Option C: Using iOS Simulator

1. **Set in `api_config.dart`**:
   ```dart
   static const String _serverHost = 'localhost';
   static const bool _isAndroidEmulator = false;
   ```

2. **Run React server** on `localhost:5000`

3. **Run Flutter app** on iOS Simulator

---

## ✅ **Step 4: Test Login**

### Test Credentials:
- **Username Format**: `firstname.fo.district.dept` (e.g., `john.fo.lhr.ctp`)
- **Password**: Your React API password

### What to Check:

1. **Open the app** → Should show Splash Screen
2. **Tap "GET STARTED"** → Should show Welcome Back Screen
3. **Enter username and password**
4. **Tap "SIGN IN"**

### Expected Results:

✅ **Success**:
- Loading indicator appears
- Navigates to Home Screen
- Shows success message: "Welcome [username]"
- Check console for: `=== API Configuration ===`

❌ **Failure**:
- Error message appears
- Check console logs for error details
- Common errors:
  - "Connection timeout" → Server not running or wrong IP
  - "Cannot connect to server" → Check IP/port or firewall
  - "401 Unauthorized" → Wrong credentials
  - "404 Not Found" → Wrong endpoint path

---

## 🔧 **Step 5: Debug Connection Issues**

### Check Console Logs:

When you run the app, you should see in the console:

```
=== API Configuration ===
Base URL: http://192.168.100.60:5000/api
Server Host: 192.168.100.60
Server Port: 5000
Use HTTPS: false
API Base Path: /api
Is Android Emulator: false
========================
```

### Common Issues & Solutions:

#### Issue 1: "Connection timeout"
**Solution:**
- Verify React server is running
- Check if port 5000 is correct
- Verify IP address matches your computer
- Check firewall settings

#### Issue 2: "Cannot connect to server"
**Solution:**
- For Android Emulator: Set `_isAndroidEmulator = true`
- For Physical Device: Ensure same Wi-Fi network
- Check React server accepts external connections (use `0.0.0.0`)

#### Issue 3: "404 Not Found"
**Solution:**
- Verify API base path is `/api`
- Check React server routes match endpoints
- Test endpoint in browser: `http://YOUR_IP:5000/api/auth/login`

#### Issue 4: "401 Unauthorized"
**Solution:**
- Verify credentials are correct
- Check React server authentication logic
- Verify token is being stored after login

---

## 🧪 **Step 6: Test Record Submission**

### After Successful Login:

1. **Go to Home Screen**
2. **Tap "Manual Registration"**
3. **Complete the 4-step form**:
   - Step 1: Biometric Capture (face scan)
   - Step 2: Personal Information
   - Step 3: Photo & Location
   - Step 4: Final Step (officer notes)

4. **Tap "Complete Registration"**

### Expected Results:

✅ **Success**:
- Shows "Case registered successfully!"
- Navigates to Confirmation Screen
- Record appears in "View Assigned Cases"

❌ **Failure**:
- Check console for error details
- Verify all required fields are filled
- Check image file sizes
- Verify token is valid

---

## 📊 **Step 7: Test Other Features**

### Test "View Assigned Cases":

1. **From Home Screen** → Tap "View Assigned Cases"
2. **Should display** all records submitted by logged-in officer
3. **Check if images load** correctly

### Test Search:

1. **Go to Search tab** (bottom navigation)
2. **Enter search query** (name, location, etc.)
3. **Should filter records** and display results

### Test Calendar:

1. **Go to Calendar tab**
2. **Should show calendar** with records highlighted
3. **Tap a date** → Should show records for that date

---

## 🔍 **Step 8: Verify API Calls**

### Check React Server Logs:

Your React server should show incoming requests:
```
POST /api/auth/login
POST /api/beggars/add
GET /api/beggars/all
```

### Check Flutter Console:

You should see Dio logs (in debug mode):
```
[Request] POST http://192.168.100.60:5000/api/auth/login
[Response] Status: 200
[Data] {token: "...", user: {...}}
```

---

## 📝 **Quick Test Checklist**

- [ ] Updated `_serverHost` in `api_config.dart`
- [ ] Verified `_serverPort` matches React server
- [ ] Set `_isAndroidEmulator` correctly
- [ ] React server is running
- [ ] Tested login with valid credentials
- [ ] Token stored after login
- [ ] Tested record submission
- [ ] Verified records appear in "My Records"
- [ ] Checked images load correctly
- [ ] Tested search functionality
- [ ] Tested calendar view

---

## 🚨 **Troubleshooting Commands**

### Test Server Connection (from Flutter app directory):
```bash
# Test if server is accessible
curl http://192.168.100.60:5000/api/auth/login

# Or use PowerShell
Invoke-WebRequest -Uri "http://192.168.100.60:5000/api/auth/login" -Method POST
```

### Check Flutter Network:
```bash
# Run with verbose logging
flutter run --verbose

# Check network permissions
flutter doctor -v
```

---

## ✅ **Success Indicators**

You'll know it's working when:

1. ✅ Login succeeds and shows welcome message
2. ✅ Console shows API configuration
3. ✅ Records can be submitted successfully
4. ✅ Records appear in "My Records"
5. ✅ Images load from `/uploads/` folder
6. ✅ No connection errors in console

---

## 🎯 **Next Steps After Testing**

Once everything works:

1. **Add missing form fields** (CNIC, police station, etc.)
2. **Implement CNIC validation**
3. **Add image compression**
4. **Implement offline support**
5. **Add error retry logic**

---

**Need Help?** Check the console logs - all API requests are logged in debug mode!

