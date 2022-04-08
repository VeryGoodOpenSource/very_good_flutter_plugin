// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface/{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface.dart';

/// The Web implementation of [{{#pascalCase}}{{project_name}}{{/pascalCase}}Platform].
class {{#pascalCase}}{{project_name}}{{/pascalCase}}Web extends {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform {
  /// Registers this class as the default instance of [{{#pascalCase}}{{project_name}}{{/pascalCase}}Platform]
  static void registerWith([Object? registrar]) {
    {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform.instance = {{#pascalCase}}{{project_name}}{{/pascalCase}}Web();
  }

  @override
  Future<String?> getPlatformName() async => 'Web';
}
