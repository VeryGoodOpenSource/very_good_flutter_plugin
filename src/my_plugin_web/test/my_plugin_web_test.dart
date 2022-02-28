import 'package:flutter_test/flutter_test.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';
import 'package:my_plugin_web/my_plugin_web.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyPluginMacOS', () {
    const kPlatformName = 'Web';
    late MyPluginWeb myPlugin;

    setUp(() async {
      myPlugin = MyPluginWeb();
    });

    test('can be registered', () {
      MyPluginWeb.registerWith();
      expect(MyPluginPlatform.instance, isA<MyPluginWeb>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await myPlugin.getPlatformName();
      expect(name, equals(kPlatformName));
    });
  });
}
