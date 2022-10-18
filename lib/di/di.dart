import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_client_handler/http_client_handler.dart';
import 'package:pbl6_mobile/app/app.dart';

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
    ..registerLazySingleton<AddressDatasource>(
      () => RemoteAddressDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<CategoryDatasource>(
      () =>
          RemoteCategoryDatasource(httpHandler: injector<HttpClientHandler>()),
    );
}
