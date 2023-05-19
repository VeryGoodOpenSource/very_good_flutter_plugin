import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_plugin_macos/my_plugin_macos.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyPluginMacOS', () {
    const kPlatformName = 'MacOS';
    late MyPluginMacOS myPlugin;
    late List<MethodCall> log;

    setUp(() async {
      myPlugin = MyPluginMacOS();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(myPlugin.methodChannel, (methodCall) async {
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
      MyPluginMacOS.registerWith();
      expect(MyPluginPlatform.instance, isA<MyPluginMacOS>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await myPlugin.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
