// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface/{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface.dart';

/// The Android implementation of [{{#pascalCase}}{{project_name}}{{/pascalCase}}Platform].
class {{#pascalCase}}{{project_name}}{{/pascalCase}}Android extends {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('{{#snakeCase}}{{project_name}}{{/snakeCase}}_android');

  /// Registers this class as the default instance of [{{#pascalCase}}{{project_name}}{{/pascalCase}}Platform]
  static void registerWith() {
    {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform.instance = {{#pascalCase}}{{project_name}}{{/pascalCase}}Android();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
