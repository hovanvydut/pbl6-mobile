import 'package:models/models.dart';

abstract class IAddressDatasource {
  Future<List<Province>> getProvinces();

  Future<List<District>> getDistrictsByProvinceId(int provinceId);

  Future<List<Ward>> getWardsByDistrictId(int districtId);
}
