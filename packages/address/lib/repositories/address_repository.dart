import 'package:address/data/iaddress_datasource.dart';
import 'package:models/models.dart';

class AddressRepository {
  AddressRepository({
    required IAddressDatasource addressDatasource,
  }) : _addressDatasource = addressDatasource;

  final IAddressDatasource _addressDatasource;

  Future<List<Province>> getProvinces() => _addressDatasource.getProvinces();

  Future<List<District>> getDistrictsByProvinceId(int provinceId) =>
      _addressDatasource.getDistrictsByProvinceId(provinceId);

  Future<List<Ward>> getWardsByDistrictId(int districtId) =>
      _addressDatasource.getWardsByDistrictId(districtId);
}
