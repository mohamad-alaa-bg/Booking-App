import 'package:booking_services/features/authentication/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  void cashedUser({required UserModel user, required String token});

  Future<UserModel> getCashedUse();

  bool isLoggedIn();

  bool logOut();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  SharedPreferences sharedPreferences;

  AuthenticationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  void cashedUser({required UserModel user, required String token}) {
    sharedPreferences.setString('userName', user.name);
    sharedPreferences.setString('email', user.email);
    sharedPreferences.setString('phoneNum', user.phoneNum);
    sharedPreferences.setString('imageUrl', user.imageUrl);
    sharedPreferences.setString('userId', user.userId);
    sharedPreferences.setBool('emailVerified', user.emailVerified);
    sharedPreferences.setString('token', token);
  }

  @override
  bool isLoggedIn() {
    return sharedPreferences.getString('token') != null;
  }

  @override
  bool logOut() {
    if (isLoggedIn()) {
      sharedPreferences.clear();
      return true;
    }
    return false;
  }

  @override
  Future<UserModel> getCashedUse() async {
    return UserModel(
        name: sharedPreferences.getString('userName') ?? '',
        email: sharedPreferences.getString('email') ?? '',
        phoneNum: sharedPreferences.getString('phoneNum') ?? '',
        imageUrl: sharedPreferences.getString('imageUrl') ?? '',
        emailVerified: sharedPreferences.getBool('emailVerified') ?? false,
        userId: sharedPreferences.getString('userId') ?? '',
        token: sharedPreferences.getString('token') ?? '');
  }
}
