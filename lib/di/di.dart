import 'package:address/address.dart';
import 'package:auth/auth.dart';
import 'package:bookmark/bookmark.dart';
import 'package:category/category.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_client_handler/http_client_handler.dart';
import 'package:media/media.dart';
import 'package:payment/payment.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';
import 'package:user/user.dart';

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
    )
    ..registerLazySingleton<IAuthDatasource>(
      () => RemoteAuthDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IUserDatasource>(
      () => RemoteUserDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IPostDatasource>(
      () => RemotePostDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IMediaDatasource>(
      () => RemoteMediaDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IBookmarkDatasource>(
      () =>
          RemoteBookmarkDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IPaymentDatasource>(
      () => RemotePaymentDatasource(httpHandler: injector<HttpClientHandler>()),
    );
}
