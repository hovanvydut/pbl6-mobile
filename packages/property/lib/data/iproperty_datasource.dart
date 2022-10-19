// ignore_for_file: one_member_abstracts

import 'package:models/models.dart';

abstract class IPropertyDatasource {
  Future<List<GroupProperty>> getGroupProperties();
}
