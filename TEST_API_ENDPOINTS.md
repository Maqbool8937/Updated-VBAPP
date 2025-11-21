# 🧪 Testing Your React API Endpoints

## ✅ **"Cannot GET /" is Normal!**

Your React API server is running correctly! The "Cannot GET /" error just means there's no route handler for the root path `/`. This is **completely normal** for API servers.

---

## 🎯 **Test These Endpoints Instead**

### **1. Test Hierarchy Endpoint** (No Auth Required)
Open in browser:
```
http://localhost:5000/api/meta/hierarchy
```

**Expected Results:**
- ✅ **200 OK** → Shows JSON with districts/departments
- ✅ **404 Not Found** → Endpoint doesn't exist (check your React routes)
- ✅ **401 Unauthorized** → Endpoint requires auth (that's fine)

---

### **2. Test Login Endpoint** (POST Request)

You can't test POST in browser directly, but you can verify it exists:

**Using PowerShell:**
```powershell
Invoke-WebRequest -Uri "http://localhost:5000/api/auth/login" -Method POST -ContentType "application/json" -Body '{"username":"test","password":"test"}'
```

**Using curl (if available):**
```bash
curl -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"username\":\"test\",\"password\":\"test\"}"
```

**Expected Results:**
- ✅ **401 Unauthorized** → Endpoint exists! (wrong credentials is expected)
- ✅ **400 Bad Request** → Endpoint exists! (missing/invalid data)
- ✅ **404 Not Found** → Endpoint doesn't exist (check your React routes)

---

### **3. Test Image Uploads Folder**

Open in browser:
```
http://localhost:5000/uploads/test.jpg
```

**Expected Results:**
- ✅ **404 Not Found** → Uploads folder exists (file not found is expected)
- ✅ **200 OK** → Image exists and loads
- ✅ **Cannot GET** → Uploads folder might not be configured

---

## 🔍 **Verify Your React Server Routes**

Check your React server code (usually `server.js`, `app.js`, or `routes/index.js`) and verify you have these routes:

```javascript
// Example Express.js routes
app.post('/api/auth/login', ...);
app.get('/api/auth/me', ...);
app.post('/api/beggars/add', ...);
app.get('/api/beggars/all', ...);
app.get('/api/meta/hierarchy', ...);
```

---

## ✅ **Quick Verification Checklist**

- [ ] React server is running (you got "Cannot GET /" which confirms it's running)
- [ ] Test `/api/meta/hierarchy` endpoint
- [ ] Test `/api/auth/login` with POST request
- [ ] Verify `/uploads/` folder exists (if using images)

---

## 🚀 **Next Step: Test from Flutter App**

Since your server is running, now test from your Flutter app:

1. **Make sure** `api_config.dart` has:
   ```dart
   static const String _serverHost = '192.168.100.60';  // Your IP
   static const String _serverPort = '5000';
   static const bool _isAndroidEmulator = false;  // or true if using emulator
   ```

2. **Run Flutter app:**
   ```bash
   flutter run
   ```

3. **Try to login** - Check console for API calls

---

## 💡 **Common React Server Configurations**

### **If using Express.js:**
```javascript
const express = require('express');
const app = express();

app.use('/api', apiRoutes);  // All API routes under /api
app.use('/uploads', express.static('uploads'));  // Serve uploads folder

app.listen(5000, () => {
  console.log('Server running on port 5000');
});
```

### **If using React with backend:**
```javascript
// Usually in server.js or index.js
app.use('/api', require('./routes/api'));
```

---

## 🎯 **What to Check in Your React Server**

1. **Port Configuration:**
   ```javascript
   app.listen(5000, ...)  // Should be 5000
   ```

2. **API Routes:**
   ```javascript
   app.use('/api', ...)  // Should have /api prefix
   ```

3. **CORS Configuration** (if needed):
   ```javascript
   app.use(cors());  // Allow Flutter app to connect
   ```

---

## ✅ **You're Good to Go!**

The "Cannot GET /" message means your server is running. Now test the actual API endpoints or proceed to test from your Flutter app!

