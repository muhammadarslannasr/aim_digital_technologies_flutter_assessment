import 'package:aim_digital_technologies_test_flutter/data/app_exceptions.dart';
import 'package:aim_digital_technologies_test_flutter/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginCubitContract {
  Future<void> logOut();

  Future<void> register();

  Future<void> login();

  void onEmailTextChange({required String email});

  void onPasswordTextChange({required String password});
}

class LoginCubit extends Cubit<LoginCubitState> implements LoginCubitContract {
  LoginCubit({required this.repo}) : super(LoginCubitInitialState.initial());

  final RepositoryImpl repo;

  @override
  void onEmailTextChange({required String email}) {
    emit(getCubitState(email: email));
  }

  @override
  void onPasswordTextChange({required String password}) {
    emit(getCubitState(password: password));
  }

  @override
  Future<void> logOut() async {
    try {
      await repo.logout();
      emit(LoginCubitLogOutSuccessState(
        loading: false,
        errMsg: '',
        email: '',
        password: '',
        userName: '',
        authStatus: state.authStatus,
      ));
    } on FetchDataException catch (e) {
      emit(LoginCubitLogoutFailureState(
        loading: false,
        errMsg: e.toString(),
        email: '',
        password: '',
        userName: state.userName,
        authStatus: state.authStatus,
      ));
    } catch (e) {
      emit(LoginCubitLogoutFailureState(
        loading: false,
        errMsg: e.toString(),
        email: '',
        password: '',
        userName: state.userName,
        authStatus: state.authStatus,
      ));
    }
  }

  @override
  Future<void> register() async {
    try {
      emit(getCubitState(loading: true));

      final credential =
          await repo.registerUser(email: state.email, password: state.password);

      emit(
        LoginCubitSuccessState(
          loading: false,
          errMsg: '',
          email: state.email,
          password: state.password,
          userName: credential.additionalUserInfo?.username ?? '',
          authStatus: AuthStatus.register,
        ),
      );
    } on FetchDataException catch (e) {
      emit(LoginCubitFailureState(
          loading: false,
          errMsg: e.toString(),
          email: state.email,
          password: state.password,
          userName: '',
          authStatus: AuthStatus.register));
    } on TimeOutException catch (e) {
      emit(LoginCubitFailureState(
        loading: false,
        errMsg: e.toString(),
        email: state.email,
        password: state.password,
        userName: '',
        authStatus: AuthStatus.register,
      ));
    } on WeakPasswordException catch (e) {
      emit(LoginCubitFailureState(
        loading: false,
        errMsg: e.toString(),
        email: state.email,
        password: state.password,
        userName: '',
        authStatus: AuthStatus.register,
      ));
    } on BadRequestException catch (e) {
      emit(LoginCubitFailureState(
        loading: false,
        errMsg: e.toString(),
        email: state.email,
        password: state.password,
        userName: '',
        authStatus: AuthStatus.register,
      ));
    }
  }

  @override
  Future<void> login() async {
    try {
      emit(getCubitState(loading: true));
      final credential =
          await repo.loginUser(email: state.email, password: state.password);
      emit(
        LoginCubitSuccessState(
          loading: false,
          errMsg: '',
          email: state.email,
          password: state.password,
          userName: credential.additionalUserInfo?.username ?? '',
          authStatus: AuthStatus.login,
        ),
      );
    } on FetchDataException catch (e) {
      // Handle no internet connection or other fetch data exceptions
      emit(LoginCubitFailureState(
        loading: false,
        errMsg: e.toString(),
        email: state.email,
        password: state.password,
        userName: '',
        authStatus: AuthStatus.login,
      ));
    } on TimeOutException catch (e) {
      emit(LoginCubitFailureState(
        loading: false,
        errMsg: e.toString(),
        email: state.email,
        password: state.password,
        userName: '',
        authStatus: AuthStatus.login,
      ));
    } on UserNotFoundException catch (_) {
      ///* user not found so need to create user and login automatically
      register();
    } on WrongPasswordException catch (e) {
      emit(LoginCubitFailureState(
        loading: false,
        errMsg: e.toString(),
        email: state.email,
        password: state.password,
        userName: '',
        authStatus: AuthStatus.login,
      ));
    } on BadRequestException catch (e) {
      emit(LoginCubitFailureState(
        loading: false,
        errMsg: e.toString(),
        email: state.email,
        password: state.password,
        userName: '',
        authStatus: AuthStatus.login,
      ));
    } catch (e) {
      emit(LoginCubitFailureState(
        loading: false,
        errMsg: e.toString(),
        email: state.email,
        password: state.password,
        userName: '',
        authStatus: AuthStatus.login,
      ));
    }
  }

  ///* get cubit state

  LoginCubitState getCubitState({
    bool? loading,
    String? errMsg,
    String? email,
    String? password,
    String? userName,
    AuthStatus? authStatus,
  }) {
    return LoginCubitInitialState(
      loading: loading ?? state.loading,
      errMsg: errMsg ?? state.errMsg,
      email: email ?? state.email,
      password: password ?? state.password,
      userName: userName ?? state.userName,
      authStatus: authStatus ?? state.authStatus,
    );
  }
}

///* states of cubit
abstract class LoginCubitState {
  final bool loading;
  final String errMsg;
  final String email;
  final String password;
  final String userName;
  final AuthStatus authStatus;

  LoginCubitState({
    required this.loading,
    required this.errMsg,
    required this.email,
    required this.password,
    required this.userName,
    required this.authStatus,
  });
}

class LoginCubitInitialState extends LoginCubitState {
  LoginCubitInitialState({
    required super.loading,
    required super.errMsg,
    required super.email,
    required super.password,
    required super.userName,
    required super.authStatus,
  });

  factory LoginCubitInitialState.initial() => LoginCubitInitialState(
        loading: false,
        errMsg: '',
        email: '',
        password: '',
        userName: '',
        authStatus: AuthStatus.login,
      );
}

class LoginCubitSuccessState extends LoginCubitState {
  LoginCubitSuccessState({
    required super.loading,
    required super.errMsg,
    required super.email,
    required super.password,
    required super.userName,
    required super.authStatus,
  });
}

class LoginCubitFailureState extends LoginCubitState {
  LoginCubitFailureState({
    required super.loading,
    required super.errMsg,
    required super.email,
    required super.password,
    required super.userName,
    required super.authStatus,
  });
}

class LoginCubitLogOutSuccessState extends LoginCubitState {
  LoginCubitLogOutSuccessState({
    required super.loading,
    required super.errMsg,
    required super.email,
    required super.password,
    required super.userName,
    required super.authStatus,
  });
}

class LoginCubitLogoutFailureState extends LoginCubitState {
  LoginCubitLogoutFailureState({
    required super.loading,
    required super.errMsg,
    required super.email,
    required super.password,
    required super.userName,
    required super.authStatus,
  });
}

enum AuthStatus {
  login,
  register,
}
