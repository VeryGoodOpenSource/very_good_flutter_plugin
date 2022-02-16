import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

/// The Windows implementation of [MyPluginPlatform].
class MyPluginWindows extends MyPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_plugin_windows');

  /// Registers this class as the default instance of [MyPluginPlatform]
  static void registerWith() {
    print('registering Windows!');
    MyPluginPlatform.instance = MyPluginWindows();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
