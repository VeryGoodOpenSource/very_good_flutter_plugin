# Very Good Flutter Plugin

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]
[![Very Good Ventures][logo_black]][very_good_ventures_link_light]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![my_plugin][build_status_badge]][build_status_link]
![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Very Good Flutter Plugin created by the [Very Good Ventures Team][very_good_ventures_link].

## Getting Started 🚀

**❗ In order to start using Very Good Flutter Plugin you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

### Running the Example

The `src` directory contains the main `my_plugin` package along with the platform interface and the platform-specific implementations.

You can run the example via:

```sh
cd src/my_plugin/example
flutter run
```

The plugin supports the following platforms:

- ✅ Android
- ✅ iOS
- ✅ Linux
- ✅ MacOS
- ✅ Web
- ✅ Windows

### Generating a Custom Plugin

This repository powers the `flutter_plugin` template exposed via [Very Good CLI][very_good_cli_link].

If you have not previously installed Very Good CLI, you can install it via:

```sh
dart pub global activate very_good_cli
```

A custom plugin can be generated via the `create` command:

```sh
very_good create my_plugin -t flutter_plugin
```

A custom description and org name can be also be provided via command line options

```sh
very_good create my_plugin -t flutter_plugin --desc "My custom description" --org-name com.example.my_plugin
```

By default, the generated plugin supports all platforms specified above. To disable support for specific platforms use the platform flags:

```sh
# Exclude Windows and Linux support
very_good create my_plugin -t flutter_plugin --windows false --linux false
```

[build_status_badge]: https://github.com/VeryGoodOpenSource/very_good_flutter_plugin/actions/workflows/my_plugin.yaml/badge.svg
[build_status_link]: https://github.com/VeryGoodOpenSource/very_good_flutter_plugin/actions/workflows/my_plugin.yaml
[coverage_badge]: src/my_plugin/coverage_badge.svg
[flutter_install_link]: https://flutter.dev/docs/get-started/install
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
