import 'package:flutter_test/flutter_test.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

class MyPluginMock extends MyPluginPlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('MyPluginPlatformInterface', () {
    late MyPluginPlatform myPluginPlatform;

    setUp(() {
      myPluginPlatform = MyPluginMock();
      MyPluginPlatform.instance = myPluginPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await MyPluginPlatform.instance.getPlatformName(),
          equals(MyPluginMock.mockPlatformName),
        );
      });
    });
  });
}
