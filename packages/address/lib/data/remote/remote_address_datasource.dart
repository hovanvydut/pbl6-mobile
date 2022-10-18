import 'package:address/data/address_datasource.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';

class RemoteAddressDatasource implements AddressDatasource {
  RemoteAddressDatasource({
    required HttpClientHandler httpHandler,
  }) : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<List<Province>> getProvinces() async {
    try {
      final provinceData = await _httpHandler.get(
        ApiPath.addressProvince,
      ) as List;
      return provinceData
          .map((e) => Province.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerErrorException {
      throw Exception();
    }
  }

  @override
  Future<List<District>> getDistrictsByProvinceId(int provinceId) async {
    try {
      final jsonResponse = await _httpHandler.get(
        ApiPath.addressDistrict,
        queryParameter: {
          'provinceId': '$provinceId',
        },
      ) as Map<String, dynamic>;
      final districtData = jsonResponse['addressDistricts'] as List;
      return districtData
          .map((e) => District.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerErrorException {
      throw Exception();
    }
  }

  @override
  Future<List<Ward>> getWardsByDistrictId(int districtId) async {
    try {
      final jsonResponse = await _httpHandler.get(
        ApiPath.addressWard,
        queryParameter: {
          'districtId': '$districtId',
        },
      ) as Map<String, dynamic>;
      final wardData = jsonResponse['addressWards'] as List;
      return wardData
          .map((e) => Ward.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerErrorException {
      throw Exception();
    }
  }
}
