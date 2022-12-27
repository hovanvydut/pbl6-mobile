import 'package:address/address.dart';
import 'package:auth/auth.dart';
import 'package:booking/booking.dart';
import 'package:bookmark/bookmark.dart';
import 'package:category/category.dart';
import 'package:config/config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_client_handler/http_client_handler.dart';
import 'package:media/media.dart';
import 'package:notification/notification.dart';
import 'package:payment/payment.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:permissions/permissions.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';
import 'package:review/review.dart';
import 'package:statistics/statistics.dart';
import 'package:uptop/uptop.dart';
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
    )
    ..registerLazySingleton<IBookingDatasource>(
      () => RemoteBookingDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IReviewDatasource>(
      () => RemoteReviewDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IUptopDatasource>(
      () => RemoteUptopDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IConfigDatasource>(
      () => RemoteConfigDatasource(httpHandler: injector<HttpClientHandler>()),
    )
    ..registerLazySingleton<IStatisticsDatasource>(
      () => RemoteStatisticsDatasource(
        httpHandler: injector<HttpClientHandler>(),
      ),
    )
    ..registerLazySingleton<INotificationDatasource>(
      () => RemoteNotificationDatasource(
        httpHandler: injector<HttpClientHandler>(),
      ),
    )
    ..registerLazySingleton<IPermissionsDatasource>(
      () => RemotePermissionsDatasource(
        httpHandler: injector<HttpClientHandler>(),
      ),
    );
}
