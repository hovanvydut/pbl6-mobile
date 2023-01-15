![homie](.github/screenshots/App_Intro.png)

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

[![Version badge](https://img.shields.io/github/v/release/hovanvydut/pbl6-mobile)](https://github.com/hovanvydut/pbl6-mobile/releases)
![Android](https://img.shields.io/badge/OS-Android-informational?logo=Android)
![iOS](https://img.shields.io/badge/OS-IOS-informational?logo=apple)

# Homie - INN Findor System - Client Mobile App

<img alt="logo.png" height="100" src=".github/screenshots/logo.png" width="100"/>

An INN Findor System mobile app created by PBL6 Team

About BE, FE End User, FE Admin, AI, Migration sides? Check out [this repository](https://github.com/hovanvydut/pbl6-homie) for more.

Initially generated by the [Very Good CLI][very_good_cli_link] 🤖

## Features 🔥

- Authentication, select role, submit register email.
- Role Permission.
- Create, View, Delete, Edit, Search, Filter, Uptop Rental post.
- Review post, create booking to view rental house.
- Review evaluation analysis.
- User management.
- User post management.
- Booking management.
- Bookmark management.
- Statistics.
- Payment management (VNPAY).
- Notifications.
- Dark mode support.

## Core structure used 🔬

- Very Good Ventures's Boring Structure, check out in this [link](https://verygood.ventures/blog/very-good-flutter-architecture) to learn more about app architecture.
- Multi-package (Mono repo).

## Packages used 💪

- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for state management solution.
- Service locator using [get_it](https://pub.dev/packages/get_it) and DI via Widget Tree.
- [go_router](https://pub.dev/packages/go_router) for routing solution, deep link.
- Structure templates using [Mason](https://brickhub.dev) brick with [own implementation](https://github.com/dungngminh/mason_bricks) and Very Good Ventures bricks.
- Secure Storage via [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage).
- [http](https://pub.dev/packages/http) ([customized](https://pub.dev/packages/http_client_handler) wrapper for http session) for api call.

## Design System/UI-UX ️🎨

- [Material Design 3](https://m3.material.io/) (some widgets aren't supported will be customized).
- [Material 3 Dynamic Color](https://m3.material.io/theme-builder#/custom).

## Environment 🚀

This project contains 2 flavors:

- development
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands with env variables:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart --dart-define BASE_URL="your_development_url"
``
# Production
$ flutter run --flavor production --target lib/main_production.dart --dart-define BASE_URL="your_production_url"
```

## Screenshots 📷

| Home Page                                                                                                              | Sign in                                                                                                                  | Select Role                                                                                                                      |
| ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| <img alt="home_page.jpg" style="object-fit:scale-down" src=".github/screenshots/home_page.jpg" width="200"/>           | <img alt="login.jpg" style="object-fit:scale-down" src=".github/screenshots/login.jpg" width="200"/>                     | <img alt="select_role.jpg" style="object-fit:scale-down" src=".github/screenshots/select_role.jpg" width="200"/>                 |
| Sign up                                                                                                                | Detail Post                                                                                                              | Search                                                                                                                           |
| <img alt="register.jpg" style="object-fit:scale-down" src=".github/screenshots/register.jpg" width="200"/>             | <img alt="detail_post.jpg" style="object-fit:scale-down" src=".github/screenshots/detail_post.jpg" width="200"/>         | <img alt="search_filter.jpg" style="object-fit:scale-down" src=".github/screenshots/search_filter.jpg" width="200"/>             |
| Filter                                                                                                                 | Detail Host                                                                                                              | Review Session                                                                                                                   |
| <img alt="filter.jpg" style="object-fit:scale-down" src=".github/screenshots/filter.jpg" width="200"/>                 | <img alt="detail_host.jpg" style="object-fit:scale-down" src=".github/screenshots/detail_host.jpg" width="200"/>         | <img alt="review_session.jpg" style="object-fit:scale-down" src=".github/screenshots/review_session.jpg" width="200"/>           |
| Create Review                                                                                                          | Create Booking                                                                                                           | Select Booking Calendar                                                                                                          |
| <img alt="create_review.jpg" style="object-fit:scale-down" src=".github/screenshots/create_review.jpg" width="200"/>   | <img alt="preview_booking.jpg" style="object-fit:scale-down" src=".github/screenshots/preview_booking.jpg" width="200"/> | <img alt="select_booking_data.jpg" style="object-fit:scale-down" src=".github/screenshots/select_booking_data.jpg" width="200"/> |
| User Panel                                                                                                             | User Info                                                                                                                | User Post                                                                                                                        |
| <img alt="user_panel.jpg" style="object-fit:scale-down" src=".github/screenshots/user_panel.jpg" width="200"/>         | <img alt="user_info.jpg" style="object-fit:scale-down" src=".github/screenshots/user_info.jpg" width="200"/>             | <img alt="user_post.jpg" style="object-fit:scale-down" src=".github/screenshots/user_post.jpg" width="200"/>                     |
| Post Action                                                                                                            | Booking List                                                                                                             | Config Freetime                                                                                                                  |
| <img alt="post_action.jpg" style="object-fit:scale-down" src=".github/screenshots/post_action.jpg" width="200"/>       | <img alt="booking_list.jpg" style="object-fit:scale-down" src=".github/screenshots/booking_list.jpg" width="200"/>       | <img alt="freetime_config.jpg" style="object-fit:scale-down" src=".github/screenshots/freetime_config.jpg" width="200"/>         |
| Bookmark                                                                                                               | Account/Debit/Credit History                                                                                             | Notifications                                                                                                                    |
| <img alt="bookmark.jpg" style="object-fit:scale-down" src=".github/screenshots/bookmark.jpg" width="200"/>             | <img alt="account.jpg" style="object-fit:scale-down" src=".github/screenshots/account.jpg" width="200"/>                 | <img alt="notifications.jpg" style="object-fit:scale-down" src=".github/screenshots/notifications.jpg" width="200"/>             |
| Create Payment                                                                                                         | Stat                                                                                                                     | Home Page dark mode                                                                                                              |
| <img alt="create_payment.gif" style="object-fit:scale-down" src=".github/screenshots/create_payment.gif" width="230"/> | <img alt="stat.jpg" style="object-fit:scale-down" src=".github/screenshots/stat.jpg" width="200"/>                       | <img alt="home_page_dark.jpg" style="object-fit:scale-down" src=".github/screenshots/home_page_dark.jpg" width="200"/>           |

## Platforms 📦

- Android
- iOS

### Android

<a href='https://play.google.com/store/apps/details?id=me.dungngminh.pbl6_mobile'>
<img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width="200"/></a>

### iOS (Coming soon)

## Contributor 🌟

<table>
  <tr>
    <td align="center"><img src="https://avatars.githubusercontent.com/u/63831488?v=4" width="100px;" alt=""/><br /><sub><b>Nguyen Minh Dung</b></sub></a><br /><a href="https://github.com/hovanvydut/pbl6-mobile/commits?author=dungngminh" title="Mobile Dev">💻📱</a> 
    <td align="center"><img src="https://avatars.githubusercontent.com/u/54426113?v=4" width="100px;" alt=""/><br /><sub><b>Ho Van Vy</b></sub></a><br /><a href="https://github.com/hovanvydut/pbl6-mobile/commits?author=hovanvydut" title="Devops">🛠</a>
</tr>

</table>

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
