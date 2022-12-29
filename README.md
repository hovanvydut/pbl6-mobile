# Homie - INN Findor System - Client Mobile App

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

Initially generated by the [Very Good CLI][very_good_cli_link] 🤖

An INN Findor System mobile app created by PBL6 Team

---

## Core structure used
- Very Good Ventures's Boring Structure, check out in this [link](https://verygood.ventures/blog/very-good-flutter-architecture) to learn more about app architecture.
- Multi-package (Mono repo).
## Libs, design system used
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for state management solution.
- Service locator using [get_it](https://pub.dev/packages/get_it) and DI via Widget Tree.
- [go_router](https://pub.dev/packages/go_router) for routing solution, deep link.
- Material Design 3 (some widgets aren't supported will be customized).
- Structure templates using Mason brick with own implementation and Very Good Ventures bricks.
## Environment 🚀

This project contains 2 flavors:

- development
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands with env variables:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart --dart-define BASE_URL="pass_your_development_url"
``
# Production
$ flutter run --flavor production --target lib/main_production.dart --dart-define BASE_URL="pass_your_production_url"
```

## Screenshots

| Home Page | Sign in | Sign up |
|-----------|---------|---------|
|           |         |         |
|           |         |         |
|           |         |         |
|           |         |         |




[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
