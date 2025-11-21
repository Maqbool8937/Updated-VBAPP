# 🔐 Login Credentials Guide

## 📋 **Username Format**

Based on your React API documentation, the username format is:

```
firstname.fo.district.dept
```

### **Format Breakdown:**
- **firstname** = Officer's first name (lowercase)
- **fo** = Field Officer (always "fo")
- **district** = District code (e.g., "lhr" for Lahore, "khi" for Karachi)
- **dept** = Department code (e.g., "ctp" for City Traffic Police)

### **Examples:**
```
john.fo.lhr.ctp
ahmed.fo.khi.ctp
sara.fo.isb.ctp
ali.fo.fsd.ctp
```

---

## 🔑 **Password**

The password is whatever was set when the user was created in your React API database.

**Common default passwords:**
- `password123`
- `123456`
- `admin`
- Or the password you set when creating the user

---

## 🧪 **How to Get Test Credentials**

### **Option 1: Check Your React API Database**

1. **Open your React API database** (MongoDB, MySQL, PostgreSQL, etc.)
2. **Find the `users` collection/table**
3. **Look for a user record** - you'll see the username and password (or password hash)

### **Option 2: Create a Test User in Your React API**

If you don't have any users, create one:

**Using your React API admin panel or database:**
```javascript
// Example user creation (check your React API code)
{
  username: "john.fo.lhr.ctp",
  password: "password123",  // Will be hashed
  email: "john@example.com",
  district: "Lahore",
  department: "City Traffic Police"
}
```

### **Option 3: Use Your React API's User Registration Endpoint**

If your React API has a registration endpoint, use it to create a test user.

---

## ✅ **Testing Your Credentials**

### **Test 1: Test in Browser/Postman**

Before testing in the mobile app, verify credentials work:

**Using PowerShell:**
```powershell
$body = @{
    username = "john.fo.lhr.ctp"
    password = "password123"
} | ConvertTo-Json

Invoke-WebRequest -Uri "http://localhost:5000/api/auth/login" -Method POST -ContentType "application/json" -Body $body
```

**Expected Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "123",
    "username": "john.fo.lhr.ctp",
    "email": "john@example.com",
    "district": "Lahore",
    "department": "City Traffic Police"
  }
}
```

### **Test 2: Test in Mobile App**

1. **Open the Flutter app**
2. **Enter username**: `john.fo.lhr.ctp` (or your test username)
3. **Enter password**: `password123` (or your test password)
4. **Tap "SIGN IN"**

**Expected Result:**
- ✅ Success → Navigates to Home Screen
- ❌ Error → Check console for details

---

## 🔍 **Common Issues**

### **Issue 1: "401 Unauthorized"**
**Solution:**
- Username or password is incorrect
- User doesn't exist in database
- Password hash doesn't match

### **Issue 2: "User not found"**
**Solution:**
- Username format is wrong
- User doesn't exist in database
- Check database for existing users

### **Issue 3: "Invalid credentials"**
**Solution:**
- Verify username format matches: `firstname.fo.district.dept`
- Check password is correct
- Verify user exists in React API database

---

## 📝 **Quick Checklist**

- [ ] Username format: `firstname.fo.district.dept`
- [ ] Username exists in React API database
- [ ] Password is correct
- [ ] React server is running
- [ ] Tested credentials in browser/Postman first
- [ ] Mobile app can connect to server

---

## 💡 **Creating Test Users**

If you need to create test users, check your React API code for:

1. **User registration endpoint** (if available)
2. **Database seed script** (usually in `/scripts` or `/seeds`)
3. **Admin panel** to create users
4. **Direct database insertion** (if you have access)

**Example seed data:**
```javascript
// In your React API seed file
const testUsers = [
  {
    username: "john.fo.lhr.ctp",
    password: "password123",  // Will be hashed
    email: "john@example.com",
    district: "Lahore",
    department: "City Traffic Police",
    role: "field_officer"
  },
  {
    username: "ahmed.fo.khi.ctp",
    password: "password123",
    email: "ahmed@example.com",
    district: "Karachi",
    department: "City Traffic Police",
    role: "field_officer"
  }
];
```

---

## 🎯 **Next Steps**

1. **Find or create a test user** in your React API
2. **Verify credentials work** in browser/Postman
3. **Test login in mobile app**
4. **If it works** → You're all set! 🎉

---

**Need help?** Check your React API documentation or database to find existing users!

