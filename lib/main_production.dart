// Copyright (c) 2022, Nguyen Minh Dung
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bootstrap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  const baseUrl = String.fromEnvironment('BASE_URL');
  if (baseUrl.isEmpty) {
    throw AssertionError('BASE_URL is not set');
  }
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: Flavor.production,
    values: FlavorValues(
      baseUrl: baseUrl,
    ),
  );
  await SentryFlutter.init(
    (options) {
      options
        ..dsn =
            'https://4aaf706c882646b9b0e63d3222e977f9@o4504311019077632.ingest.sentry.io/4504311040835584'
        ..tracesSampleRate = 0.4;
      // Set tracesSampleRate to 1.0 
      //to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
    },
    appRunner: () async => bootstrap(App.new),
  );
}
