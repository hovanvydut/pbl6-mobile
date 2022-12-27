import 'package:models/models.dart' show Permission;

// ignore: one_member_abstracts
abstract class IPermissionsDatasource {
  Future<List<Permission>> getUserPermissions();
}
