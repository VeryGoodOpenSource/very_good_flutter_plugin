// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface/{{#snakeCase}}{{project_name}}{{/snakeCase}}_platform_interface.dart';
import 'package:{{#snakeCase}}{{project_name}}{{/snakeCase}}_windows/{{#snakeCase}}{{project_name}}{{/snakeCase}}_windows.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}Windows', () {
    const kPlatformName = 'Windows';
    late {{#pascalCase}}{{project_name}}{{/pascalCase}}Windows {{#camelCase}}{{project_name}}{{/camelCase}};
    late List<MethodCall> log;

    setUp(() async {
      {{#camelCase}}{{project_name}}{{/camelCase}} = {{#pascalCase}}{{project_name}}{{/pascalCase}}Windows();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
          .setMockMethodCallHandler({{#camelCase}}{{project_name}}{{/camelCase}}.methodChannel, (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      {{#pascalCase}}{{project_name}}{{/pascalCase}}Windows.registerWith();
      expect({{#pascalCase}}{{project_name}}{{/pascalCase}}Platform.instance, isA<{{#pascalCase}}{{project_name}}{{/pascalCase}}Windows>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await {{#camelCase}}{{project_name}}{{/camelCase}}.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
