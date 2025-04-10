class User {
  final int userId;
  final String user;

  const User({required this.userId, required this.user});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'user': String user} => User(
          userId: userId,
          user: user,
        ),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}
