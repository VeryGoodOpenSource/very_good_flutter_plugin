// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';

/// The Web implementation of [{{project_name.pascalCase()}}Platform].
class {{project_name.pascalCase()}}Web extends {{project_name.pascalCase()}}Platform {
  /// Registers this class as the default instance of [{{project_name.pascalCase()}}Platform]
  static void registerWith([Object? registrar]) {
    {{project_name.pascalCase()}}Platform.instance = {{project_name.pascalCase()}}Web();
  }

  @override
  Future<String?> getPlatformName() async => 'Web';
}
