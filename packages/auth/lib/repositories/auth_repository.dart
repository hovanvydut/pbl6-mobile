import 'package:auth/data/iauth_datasource.dart';

class AuthRepository {
  const AuthRepository({required IAuthDatasource authDatasource})
      : _authDatasource = authDatasource;

  final IAuthDatasource _authDatasource;

  Future<void> login({required String email, required String password}) =>
      _authDatasource.login(email: email, password: password);
}
