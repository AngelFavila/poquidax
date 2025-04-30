class AppUser {
  final String uuid;
  final String requestToken;

  AppUser({
    required this.uuid,
    required this.requestToken,
  });

  AppUser copyWith({
    String? uuid,
    String? requestToken,
  }) {
    return AppUser(
      uuid: uuid ?? this.uuid,
      requestToken: requestToken ?? this.requestToken,
    );
  }
}
