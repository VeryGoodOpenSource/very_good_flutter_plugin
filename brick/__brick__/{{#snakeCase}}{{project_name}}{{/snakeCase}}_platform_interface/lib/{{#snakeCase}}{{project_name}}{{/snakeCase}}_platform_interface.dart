// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface/src/method_channel_{{#snakeCase}}{{project_name}}{{/snakeCase}}.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of {{#snakeCase}}{{project_name}}{{/snakeCase}} must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `{{#pascalCase}}{{project_name}}{{/pascalCase}}`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [{{#pascalCase}}{{project_name}}{{/pascalCase}}Platform] methods.
abstract class {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform extends PlatformInterface {
  /// Constructs a {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform.
  {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform() : super(token: _token);

  static final Object _token = Object();

  static {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform _instance = MethodChannel{{#pascalCase}}{{project_name}}{{/pascalCase}}();

  /// The default instance of [{{#pascalCase}}{{project_name}}{{/pascalCase}}Platform] to use.
  ///
  /// Defaults to [MethodChannel{{#pascalCase}}{{project_name}}{{/pascalCase}}].
  static {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [{{#pascalCase}}{{project_name}}{{/pascalCase}}Platform] when they register themselves.
  static set instance({{#pascalCase}}{{project_name}}{{/pascalCase}}Platform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<String?> getPlatformName();
}
