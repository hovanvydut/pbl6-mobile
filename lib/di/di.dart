import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_client_handler/http_client_handler.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:property/data/iproperty_datasource.dart';
import 'package:property/data/remote/remote_property_datasource.dart';

final injector = GetIt.instance;

void initDependences() {
  injector
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(
      () => HttpClientHandler(
        client: injector<http.Client>(),
        baseUrl: FlavorConfig.instance.values.baseUrl,
      ),
    )
    ..registerLazySingleton<IAddressDatasource>(
      () => RemoteAddressDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<ICategoryDatasource>(
      () =>
          RemoteCategoryDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IPropertyDatasource>(
      () =>
          RemotePropertyDatasource(httpHandler: injector<HttpClientHandler>()),
    );
}
