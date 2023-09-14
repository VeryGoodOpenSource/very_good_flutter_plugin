import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:fluttium/fluttium.dart';

/// {@template check_platform_name}
/// An action that checks the expected platform name.
///
/// Usage:
///
/// ```yaml
/// - checkPlatformName:
/// ```
/// {@endtemplate}
class CheckPlatformName extends Action {
  /// {@macro check_platform_name}
  const CheckPlatformName();

  String get _expectedPlatformName {
    if (kIsWeb) return 'Web';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isLinux) return 'Linux';
    if (Platform.isMacOS) return 'MacOS';
    if (Platform.isWindows) return 'Windows';
    throw UnsupportedError('Unsupported platform ${Platform.operatingSystem}');
  }

  @override
  Future<bool> execute(Tester tester) async {
    return ExpectVisible(
      text: 'Platform Name: $_expectedPlatformName',
    ).execute(tester);
  }

  @override
  String description() => 'Check platform name: "$_expectedPlatformName"';
}
