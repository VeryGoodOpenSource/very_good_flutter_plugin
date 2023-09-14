# Very Good Flutter Plugin

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]
[![Very Good Ventures][logo_black]][very_good_ventures_link_light]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![my_plugin][build_status_badge]][build_status_link]
![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A Very Good Flutter Plugin created by the [Very Good Ventures Team][very_good_ventures_link].

---

## Getting Started 🚀

**❗ In order to start using Very Good Flutter Plugin you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

### Running the Example ⚙️

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

### Generating a Custom Plugin 📦

The Very Good Flutter Plugin template is available through an independent [mason][mason_link] brick or via the [Very Good CLI][very_good_cli_link].

If you have not previously installed Very Good CLI, you can install it via:

### Very Good CLI usage

Very Good CLI usage docs are available [here][cli_docs_usage]. 

## Testing 🧪

Very Good Flutter Plugin ships with 100% code coverage. To learn more about why we believe 100% code coverage is important and other testing best practices [read our guide to Flutter testing][very_good_testing_blog_link].

### Running Tests 🧑‍🔬

Each platform implementation includes tests which can be run via:

```sh
flutter test
```

## Continuous Integration 🤖

Very Good Flutter Plugin comes with a built-in [GitHub Actions workflow][github_actions_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code using [Very Good Workflows][very_good_workflows_link]. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Coverage GitHub Action][very_good_coverage_link].

In addition, there are E2E tests as part of the `my_plugin` workflow to ensure that the plugin correctly integrates with the host application on each platform.

[build_status_badge]: https://github.com/VeryGoodOpenSource/very_good_flutter_plugin/actions/workflows/my_plugin.yaml/badge.svg
[build_status_link]: https://github.com/VeryGoodOpenSource/very_good_flutter_plugin/actions/workflows/my_plugin.yaml
[coverage_badge]: src/my_plugin/my_plugin/coverage_badge.svg
[mason_link]: https://github.com/felangel/mason
[flutter_install_link]: https://flutter.dev/docs/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[github_workflow_link]: https://docs.github.com/en/enterprise-cloud@latest/actions/using-workflows
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
[very_good_workflows_link]: https://github.com/verygoodopensource/very_good_workflows
[very_good_testing_blog_link]: https://verygood.ventures/blog/guide-to-flutter-testing
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[cli_docs_usage]: https://cli.vgv.dev/docs/templates/federated_plugin
