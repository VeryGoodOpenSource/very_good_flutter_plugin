// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface/{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface.dart';
import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_web/{{#snakeCase}}{{project_name}}{{/snakeCase}}_web.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}Web', () {
    const kPlatformName = 'Web';
    late {{#pascalCase}}{{project_name}}{{/pascalCase}}Web {{#camelCase}}{{project_name}}{{/camelCase}};

    setUp(() async {
      {{#camelCase}}{{project_name}}{{/camelCase}} = {{#pascalCase}}{{project_name}}{{/pascalCase}}Web();
    });

    test('can be registered', () {
      {{#pascalCase}}{{project_name}}{{/pascalCase}}Web.registerWith();
      expect({{#pascalCase}}{{project_name}}{{/pascalCase}}Platform.instance, isA<{{#pascalCase}}{{project_name}}{{/pascalCase}}Web>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await {{#camelCase}}{{project_name}}{{/camelCase}}.getPlatformName();
      expect(name, equals(kPlatformName));
    });
  });
}
