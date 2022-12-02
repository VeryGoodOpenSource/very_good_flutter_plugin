// Copyright (c) {{current_year}}, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:{{project_name.snakeCase()}}_platform_interface/{{project_name.snakeCase()}}_platform_interface.dart';

/// An implementation of [{{project_name.pascalCase()}}Platform] that uses method channels.
class MethodChannel{{project_name.pascalCase()}} extends {{project_name.pascalCase()}}Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('{{project_name.snakeCase()}}');

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
