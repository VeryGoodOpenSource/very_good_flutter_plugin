import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';
import 'package:my_plugin_windows/my_plugin_windows.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyPluginWindows', () {
    const kPlatformName = 'Windows';
    late MyPluginWindows myPlugin;
    late List<MethodCall> log;

    setUp(() async {
      myPlugin = MyPluginWindows();

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
      MyPluginWindows.registerWith();
      expect(MyPluginPlatform.instance, isA<MyPluginWindows>());
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
