import 'package:mason/mason.dart';

void run(HookContext context) {
  const availablePlatforms = [
    'android',
    'ios',
    'macos',
    'linux',
    'web',
    'windows',
  ];
  final selectedPlatforms = context.vars['platforms'] as List;
  for (final platform in availablePlatforms) {
    context.vars[platform] = selectedPlatforms.contains(platform);
  }
}
