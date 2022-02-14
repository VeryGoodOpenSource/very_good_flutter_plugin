import 'package:my_plugin_platform_interface/src/method_channel_my_plugin.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of my_plugin must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `MyPlugin`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [MyPluginPlatform] methods.
abstract class MyPluginPlatform extends PlatformInterface {
  /// Constructs a MyPluginPlatform.
  MyPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyPluginPlatform _instance = MethodChannelMyPlugin();

  /// The default instance of [MyPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyPlugin].
  static MyPluginPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [MyPluginPlatform] when they register themselves.
  static set instance(MyPluginPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<String?> getPlatformName();
}
