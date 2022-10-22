abstract class IAuthDatasource {
  Future<void> login({required String email, required String password});

  // Future<void> register({required String email.})

  Future<void> removeToken();
}
