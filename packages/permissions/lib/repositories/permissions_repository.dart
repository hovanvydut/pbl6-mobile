import 'package:models/models.dart';
import 'package:permissions/permissions.dart';

class PermissionsRepository {
  PermissionsRepository({required IPermissionsDatasource permissionsDatasource})
      : _permissionsDatasource = permissionsDatasource;

  final IPermissionsDatasource _permissionsDatasource;

  Future<List<Permission>> getUserPermissions() =>
      _permissionsDatasource.getUserPermissions();
}
