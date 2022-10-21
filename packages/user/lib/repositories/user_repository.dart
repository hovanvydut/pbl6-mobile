import 'package:models/models.dart';
import 'package:user/data/iuser_datasource.dart';

class UserRepository {
  const UserRepository({
    required IUserDatasource userDatasource,
  }) : _userDatasource = userDatasource;
  final IUserDatasource _userDatasource;

  Future<User?> getUserInformation() => _userDatasource.getUserInformation();

  Future<User> getUserByUserId(int userId) =>
      _userDatasource.getUserByUserId(userId);

  Future<void> updateUserInformation(User user) =>
      _userDatasource.updateUserInformation(user);
}
