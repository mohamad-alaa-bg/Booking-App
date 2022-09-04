import 'package:bloc/bloc.dart';
import 'package:booking_services/features/authentication/domain/entities/user_entity.dart';
import 'package:booking_services/features/authentication/domain/usecases/login_use_case.dart';
import 'package:booking_services/features/authentication/domain/usecases/logout_use_case.dart';
import 'package:booking_services/features/authentication/domain/usecases/signup_use_case.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final LogoutUseCase logoutUseCase;

  AuthenticationBloc(
      {required this.loginUseCase,
      required this.signupUseCase,
      required this.logoutUseCase})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is LoginEvent) {
        await _login(event, emit);
      }
      if (event is SignUpEvent) {
        await _signUp(event, emit);
      }
      if (event is LogoutEvent) {
        _logout(emit);
      }
    });
  }

  void _logout(Emitter<AuthenticationState> emit) {
    emit(LoadingState());
    logoutUseCase();
    emit(LogoutSuccessfullyState());
  }

  Future<void> _login(
      LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());
    var result = await loginUseCase(
        params: LoginParams(email: event.email, password: event.password));
    result.fold((l) => emit(AuthErrorState(message: l.message)),
        (r) => emit(LoginSuccessfullyState(user: r)));
  }

  Future<void> _signUp(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());
    var result = await signupUseCase(
        params: SignupParams(
            email: event.email,
            password: event.password,
            username: event.username,
            phoneNum: event.phoneNum));
    result.fold((l) => emit(AuthErrorState(message: l.message)), (r) {
      emit(SignUpSuccessfullyState(user: r));
    });
  }
}
