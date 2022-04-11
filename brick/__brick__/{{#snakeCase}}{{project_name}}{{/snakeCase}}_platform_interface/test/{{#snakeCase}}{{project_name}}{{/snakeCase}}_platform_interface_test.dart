// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface/{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface.dart';

class {{#pascalCase}}{{project_name}}{{/pascalCase}}Mock extends {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}PlatformInterface', () {
    late {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform {{#camelCase}}{{project_name}}{{/camelCase}}Platform;

    setUp(() {
      {{#camelCase}}{{project_name}}{{/camelCase}}Platform = {{#pascalCase}}{{project_name}}{{/pascalCase}}Mock();
      {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform.instance = {{#camelCase}}{{project_name}}{{/camelCase}}Platform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await {{#pascalCase}}{{project_name}}{{/pascalCase}}Platform.instance.getPlatformName(),
          equals({{#pascalCase}}{{project_name}}{{/pascalCase}}Mock.mockPlatformName),
        );
      });
    });
  });
}
