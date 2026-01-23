class User {
  final String? id;
  final String username;
  final String? email;
  final String? phone;
  final String? nickname;
  final String? avatarUrl;
  final List<String>? roles;
  final String? createdAt;

  User({
    this.id,
    required this.username,
    this.email,
    this.phone,
    this.nickname,
    this.avatarUrl,
    this.roles,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String?,
    username: json['username'] as String,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    nickname: json['nickname'] as String?,
    avatarUrl: json['avatarUrl'] as String?,
    roles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    createdAt: json['createdAt'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'phone': phone,
    'nickname': nickname,
    'avatarUrl': avatarUrl,
    'roles': roles,
    'createdAt': createdAt,
  };
}

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final User? user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'user': user?.toJson(),
  };
}
