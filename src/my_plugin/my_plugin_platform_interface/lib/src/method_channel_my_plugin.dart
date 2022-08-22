import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

/// An implementation of [MyPluginPlatform] that uses method channels.
class MethodChannelMyPlugin extends MyPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_plugin');

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }
}
