abstract class IAuthDatasource {
  Future<void> login({required String email, required String password});

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
  });

  Future<void> removeToken();
}
