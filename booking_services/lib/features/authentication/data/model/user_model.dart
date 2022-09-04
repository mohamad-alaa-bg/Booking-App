import 'package:booking_services/features/authentication/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  @override
  final String name;
  @override
  final String email;
  @override
  final String phoneNum;
  @override
  final String imageUrl;
  @override
  final bool emailVerified;
  @override
  final String userId;
  @override
  final String token;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.imageUrl,
    required this.emailVerified,
    required this.userId,
    required this.token,
  }) : super(
            name: name,
            email: email,
            phoneNum: phoneNum,
            imageUrl: imageUrl,
            emailVerified: emailVerified,
            userId: userId,
            token: token);

  factory UserModel.fromUserCredential(
      UserCredential userCredential, String token) {
    return UserModel(
      name: userCredential.user?.displayName ?? '',
      email: userCredential.user?.email ?? '',
      phoneNum: userCredential.user?.phoneNumber ?? '',
      imageUrl: userCredential.user?.photoURL ?? '',
      emailVerified: userCredential.user?.emailVerified ?? false,
      userId: userCredential.user?.uid ?? '',
      token: token,
    );
  }

  factory UserModel.fromUserJson(Map<String, dynamic> user) {
    return UserModel(
      name: user['UserName'],
      email: user['Email'],
      phoneNum: user['Phone num'],
      imageUrl: user['Image Url'],
      emailVerified: user['Email Verified'],
      userId: user['UserId'],
      token: '',
    );
  }

  Map<String, dynamic> toJson() => {
        'UserName': name,
        'Email': email,
        'Phone num': phoneNum,
        'Image Url': imageUrl,
        'Email Verified': emailVerified,
        'UserId': userId
      };
}
