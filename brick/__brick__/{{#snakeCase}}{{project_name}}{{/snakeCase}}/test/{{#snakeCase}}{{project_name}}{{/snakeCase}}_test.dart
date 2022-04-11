// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}/{{#snakeCase}}{{project_name}}{{/snakeCase}}.dart';
import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface/{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Platform extends Mock
    with MockPlatformInterfaceMixin
    implements {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}', () {
    late {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform myPluginPlatform;

    setUp(() {
      myPluginPlatform = Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Platform();
      {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform.instance = myPluginPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => myPluginPlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => myPluginPlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
