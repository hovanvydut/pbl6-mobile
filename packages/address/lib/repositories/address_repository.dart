import 'package:address/data/address_datasource.dart';
import 'package:models/models.dart';

class AddressRepository {
  AddressRepository({
    required AddressDatasource addressDatasource,
  }) : _addressDatasource = addressDatasource;

  final AddressDatasource _addressDatasource;

  Future<List<Province>> getProvinces() => _addressDatasource.getProvinces();

  Future<List<District>> getDistrictsByProvinceId(int provinceId) =>
      _addressDatasource.getDistrictsByProvinceId(provinceId);

  Future<List<Ward>> getWardsByDistrictId(int districtId) =>
      _addressDatasource.getWardsByDistrictId(districtId);
}
