// Copyright (c) 2022, Nguyen Minh Dung
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
          headline4: AppTextTheme.headline4,
          headline5: AppTextTheme.headline5,
          headline6: AppTextTheme.headline6,
          bodyText1: AppTextTheme.body1,
          bodyText2: AppTextTheme.body2,
          subtitle1: AppTextTheme.subtitle1,
          subtitle2: AppTextTheme.subtitle2,
          caption: AppTextTheme.caption,
          button: AppTextTheme.button,
        ),
        fontFamily: FontFamily.nunito,
        scaffoldBackgroundColor: AppPalette.backgroundColor,
        primaryColor: AppPalette.primaryColor,
        errorColor: AppPalette.errorColor,
      ),
      title: 'Shopee Fake',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
