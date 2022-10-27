// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bootstrap.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.development,
    values: FlavorValues(baseUrl: 'https://node-1.silk-cat.software'),
  );
  bootstrap(App.new);
}
