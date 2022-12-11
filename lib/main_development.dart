// Copyright (c) 2022, Nguyen Minh Dung
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: Flavor.development,
    values: FlavorValues(
      baseUrl: 'https://node-2.silk-cat.software',
    ),
  );
  await bootstrap(App.new);
}
