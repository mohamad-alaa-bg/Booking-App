import 'package:booking_services/features/authentication/data/data_sources/authentication_local_data_source.dart';
import 'package:booking_services/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:booking_services/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:booking_services/features/authentication/domain/repository/authentication_repository.dart';
import 'package:booking_services/features/authentication/domain/usecases/login_use_case.dart';
import 'package:booking_services/features/authentication/domain/usecases/logout_use_case.dart';
import 'package:booking_services/features/authentication/domain/usecases/signup_use_case.dart';
import 'package:booking_services/features/authentication/presentation/Bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> getAuthenticationDependencies(GetIt sl) async {
  sl.registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  sl.registerFactory<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerFactory<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authRemoteDataSource: sl(), authenticationLocalDataSource: sl()));
  sl.registerFactory(() => LoginUseCase(authenticationRepository: sl()));
  sl.registerFactory(() => SignupUseCase(authenticationRepository: sl()));
  sl.registerFactory(() => LogoutUseCase(authenticationRepository: sl()));
  sl.registerFactory(() => AuthenticationBloc(
      loginUseCase: sl(), signupUseCase: sl(), logoutUseCase: sl()));
}
