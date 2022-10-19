// Copyright (c) 2022, Nguyen Minh Dung
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:address/address.dart';
import 'package:category/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/di/di.dart';
import 'package:pbl6_mobile/l10n/l10n.dart';
import 'package:property/repositories/property_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
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
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: FontFamily.nunito,
        textTheme: AppTextTheme().textTheme,
        scaffoldBackgroundColor: lightColorScheme.background,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: FontFamily.nunito,
        textTheme: AppTextTheme().textTheme,
        scaffoldBackgroundColor: darkColorScheme.background,
      ),
      title: 'Tìm phòng trọ hehe',
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

// import 'package:flutter/material.dart';
// import 'package:multiselect/mutilselect_test.dart';

// class App extends StatelessWidget {
//   // This widget is the root of your application.
//   const App();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<String> selected = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: DropDownMultiSelect(
//             onChanged: (List<String> x) {
//               setState(() {
//                 selected = x;
//               });
//             },
//             options: const ['a', 'b', 'c', 'd'],
//             selectedValues: selected,
//             whenEmpty: 'Select Something',
//           ),
//         ),
//       ),
//     );
//   }
// }
