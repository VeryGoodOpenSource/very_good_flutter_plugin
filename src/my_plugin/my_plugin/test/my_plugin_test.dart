import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_plugin/my_plugin.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyPluginPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements MyPluginPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MyPlugin', () {
    late MyPluginPlatform myPluginPlatform;

    setUp(() {
      myPluginPlatform = MockMyPluginPlatform();
      MyPluginPlatform.instance = myPluginPlatform;
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
