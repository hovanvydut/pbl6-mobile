import 'package:models/models.dart';

abstract class IUserDatasource {
  Future<User?> getUserInformation();

  Future<void> updateUserInformation(User user);

  Future<User> getUserByUserId(int userId);
}
