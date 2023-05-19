import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_plugin_android/my_plugin_android.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyPluginAndroid', () {
    const kPlatformName = 'Android';
    late MyPluginAndroid myPlugin;
    late List<MethodCall> log;

    setUp(() async {
      myPlugin = MyPluginAndroid();

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
      MyPluginAndroid.registerWith();
      expect(MyPluginPlatform.instance, isA<MyPluginAndroid>());
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
