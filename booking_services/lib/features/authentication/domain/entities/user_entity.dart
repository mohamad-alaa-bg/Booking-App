class UserEntity {
  final String name;
  final String email;
  final String phoneNum;
  final String imageUrl;
  final bool emailVerified;
  final String userId;
  final String token;

  UserEntity({
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.imageUrl,
    required this.emailVerified,
    required this.userId,
    required this.token,
  });
}
