import 'package:booking_services/core/dependency_register/authentication_dependency.dart';
import 'package:booking_services/core/dependency_register/booking_dependencey.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> slInit() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  await getAuthenticationDependencies(sl);
  await getBookingDependency(sl);
}
