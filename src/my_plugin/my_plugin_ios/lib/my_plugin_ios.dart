import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

/// The iOS implementation of [MyPluginPlatform].
class MyPluginIOS extends MyPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_plugin_ios');

  /// Registers this class as the default instance of [MyPluginPlatform]
  static void registerWith() {
    MyPluginPlatform.instance = MyPluginIOS();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
