// Copyright (c) 2022, Nguyen Minh Dung
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:address/address.dart';
import 'package:auth/auth.dart';
import 'package:booking/booking.dart';
import 'package:bookmark/bookmark.dart';
import 'package:category/category.dart';
import 'package:config/config.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media/media.dart';
import 'package:notification/notification.dart';
import 'package:payment/payment.dart';
import 'package:pbl6_mobile/di/di.dart';
import 'package:post/post.dart';
import 'package:property/property.dart';
import 'package:review/review.dart';
import 'package:statistics/repositories/statistics_repository.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uptop/uptop.dart';
import 'package:user/user.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log(
      'onBlocCreate -- ${bloc.runtimeType}',
      name: '${bloc.runtimeType}_CREATE',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onAddEvent -- $event', name: '${bloc.runtimeType}_EVENT');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
      'onStateTransition -- ${bloc.runtimeType}\n'
      'ADD_EVENT: ${transition.event}\n'
      'CURRENT_STATE: ${transition.currentState}\n'
      'NEXT_STATE: ${transition.nextState}',
      name: '${bloc.runtimeType}_TRANSITION',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      'onError -- ${bloc.runtimeType}, $error',
      name: '${bloc.runtimeType}_ERROR',
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log(
      'onBlocClose -- ${bloc.runtimeType}',
      name: '${bloc.runtimeType}_CLOSE',
    );
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  Bloc.observer = AppBlocObserver();
  initDependences();
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  await runZonedGuarded(
    () async => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (_) => AddressRepository(addressDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => CategoryRepository(categoryDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => PropertyRepository(propertyDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => AuthRepository(authDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => UserRepository(userDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => PostRepository(postDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => MediaRepository(mediaDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => BookmarkRepository(bookmarkDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => PaymentRepository(paymentDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => BookingRepository(bookingDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => ReviewRepository(reviewDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => UptopRepository(uptopDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) => ConfigRepository(configDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) =>
                StatisticsRepository(statisticsDatasource: injector()),
          ),
          RepositoryProvider(
            create: (_) =>
                NotificationRepository(notificationDatasource: injector()),
          ),
        ],
        child: await builder(),
      ),
    ),
    (error, stackTrace) =>
        log(error.toString(), stackTrace: stackTrace, name: 'BLOC_ERROR'),
  );
}
