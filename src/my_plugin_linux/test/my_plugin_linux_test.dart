import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';
import 'package:my_plugin_linux/my_plugin_linux.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyPluginLinux', () {
    const kPlatformName = 'Linux';
    late MyPluginLinux myPlugin;
    late List<MethodCall> log;

    setUp(() async {
      myPlugin = MyPluginLinux();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
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
      MyPluginLinux.registerWith();
      expect(MyPluginPlatform.instance, isA<MyPluginLinux>());
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
