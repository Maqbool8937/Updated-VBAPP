class User {
  final String id;
  final String username;
  final String email;
  final String role;
  final String department;
  final String district;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.department,
    required this.district,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['_id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      department: json['department'] ?? '',
      district: json['district'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'department': department,
      'district': district,
    };
  }
}

