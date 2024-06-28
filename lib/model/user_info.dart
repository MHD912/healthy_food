class UserInfo {
  String token;
  int userId;
  bool isLoggedIn;
  UserInfo({
    required this.token,
    required this.userId,
    required this.isLoggedIn,
  });

  factory UserInfo.fromMap(Map<String, dynamic> data) {
    return UserInfo(
      userId: data['user_id'] ?? -1,
      token: data['token'] ?? "",
      isLoggedIn: data['is_logged_in'] ?? false,
    );
  }
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.from(
      {
        'user_id': userId,
        'token': token,
        'is_logged_in': isLoggedIn,
      },
    );
  }

  void clearData() {
    isLoggedIn = false;
    token = "";
    userId = -1;
  }

  @override
  String toString() {
    return "{token: $token, user_id: $userId, logged_in: $isLoggedIn}";
  }
}
