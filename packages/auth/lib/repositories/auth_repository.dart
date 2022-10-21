import 'package:auth/data/iauth_datasource.dart';

class AuthRepository {
  const AuthRepository({required IAuthDatasource authDatasource})
      : _authDatasource = authDatasource;

  final IAuthDatasource _authDatasource;

  Future<void> login({required String email, required String password}) =>
      _authDatasource.login(email: email, password: password);

  Future<void> register({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String identityNumber,
    required String avatar,
    required String address,
    required int wardId,
    required int roleId,
  }) =>
      _authDatasource.register(
        address: address,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        avatar: avatar,
        displayName: displayName,
        identityNumber: identityNumber,
        roleId: roleId,
        wardId: wardId,
      );

  Future<void> removeToken() => _authDatasource.removeToken();
}
