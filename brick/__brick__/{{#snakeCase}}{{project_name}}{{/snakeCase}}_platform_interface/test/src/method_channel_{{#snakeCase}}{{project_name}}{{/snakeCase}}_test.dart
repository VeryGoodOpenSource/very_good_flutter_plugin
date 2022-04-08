// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface/src/method_channel_{{#snakeCase}}{{project_name}}{{/snakeCase}}.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kPlatformName = 'platformName';

  group('$MethodChannel{{#pascalCase}}{{project_name}}{{/pascalCase}}', () {
    late MethodChannel{{#pascalCase}}{{project_name}}{{/pascalCase}} methodChannel{{#pascalCase}}{{project_name}}{{/pascalCase}};
    final log = <MethodCall>[];

    setUp(() async {
      methodChannel{{#pascalCase}}{{project_name}}{{/pascalCase}} = MethodChannel{{#pascalCase}}{{project_name}}{{/pascalCase}}()
        ..methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'getPlatformName':
              return kPlatformName;
            default:
              return null;
          }
        });
    });

    tearDown(log.clear);

    test('getPlatformName', () async {
      final platformName = await methodChannel{{#pascalCase}}{{project_name}}{{/pascalCase}}.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(platformName, equals(kPlatformName));
    });
  });
}
