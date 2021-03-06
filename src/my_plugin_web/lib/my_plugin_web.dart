import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

/// The Web implementation of [MyPluginPlatform].
class MyPluginWeb extends MyPluginPlatform {
  /// Registers this class as the default instance of [MyPluginPlatform]
  static void registerWith([Object? registrar]) {
    MyPluginPlatform.instance = MyPluginWeb();
  }

  @override
  Future<String?> getPlatformName() async => 'Web';
}
