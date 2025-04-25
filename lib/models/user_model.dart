class User {
  final String id;
  final String username;
  final String email;
  final String phone;
  final int vehicleCount;
  final String? avatar;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.vehicleCount,
    this.avatar,
  });

  // 从JSON映射创建User对象
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      vehicleCount: json['vehicleCount'] as int,
      avatar: json['avatar'] as String?,
    );
  }

  // 将User对象转换为JSON映射
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'vehicleCount': vehicleCount,
      'avatar': avatar,
    };
  }

  // 创建User对象的副本并更新属性
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? phone,
    int? vehicleCount,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      vehicleCount: vehicleCount ?? this.vehicleCount,
      avatar: avatar ?? this.avatar,
    );
  }
} 