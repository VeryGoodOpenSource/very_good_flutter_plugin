import 'dart:io';
import 'package:path/path.dart' as path;

const _pluginDependencies = '''
  {{project_name.snakeCase()}}_android:
    path: ../{{project_name.snakeCase()}}_android
  {{project_name.snakeCase()}}_ios:
    path: ../{{project_name.snakeCase()}}_ios
  {{project_name.snakeCase()}}_linux:
    path: ../{{project_name.snakeCase()}}_linux
  {{project_name.snakeCase()}}_macos:
    path: ../{{project_name.snakeCase()}}_macos
  {{project_name.snakeCase()}}_platform_interface:
    path: ../{{project_name.snakeCase()}}_platform_interface
  {{project_name.snakeCase()}}_web:
    path: ../{{project_name.snakeCase()}}_web
  {{project_name.snakeCase()}}_windows:
    path: ../{{project_name.snakeCase()}}_windows''';

const _pluginPlatforms = '''
flutter:
  plugin:
    platforms:
      android:
        default_package: {{project_name.snakeCase()}}_android
      ios:
        default_package: {{project_name.snakeCase()}}_ios
      macos:
        default_package: {{project_name.snakeCase()}}_macos
      linux:
        default_package: {{project_name.snakeCase()}}_linux
      web:
        default_package: {{project_name.snakeCase()}}_web
      windows:
        default_package: {{project_name.snakeCase()}}_windows''';

final _staticPath = path.join('tool', 'generator', 'static');
final _githubPath = path.join('.github');
final _gitHubWorkflowsPath =
    path.join(_targetPath, 'my_plugin', '.github', 'workflows');
final _sourcePath = path.join('src');
final _targetPath = path.join('brick', '__brick__');
final _androidPath =
    path.join(_targetPath, 'my_plugin', 'my_plugin_android', 'android');
final _androidKotlinPath = path.join(_androidPath, 'src', 'main', 'kotlin');
final _sourceMyPluginKtPath = path.join(
  _androidKotlinPath,
  'com',
  'example',
  'my_plugin',
  'MyPluginPlugin.kt',
);
final _targetMyPluginKtPath = path.join(
  _androidKotlinPath,
  '{{org_name.pathCase()}}',
  '{{project_name.pascalCase()}}Plugin.kt',
);

const platforms = [
  'android',
  'ios',
  'linux',
  'macos',
  'web',
  'windows',
];

final excludedFiles = [
  path.join(
    _targetPath,
    'my_plugin',
    '.github',
    'workflows',
    'generate_template.yaml',
  ),
  path.join(_targetPath, 'my_plugin', '.github', 'CODEOWNERS'),
];

void main() async {
  // Remove Previously Generated Files
  final targetDir = Directory(_targetPath);
  if (targetDir.existsSync()) {
    await targetDir.delete(recursive: true);
  }

  // Copy Project Files
  await Future.wait([
    Shell.cp(_sourcePath, _targetPath),
    Shell.cp(_githubPath, path.join(_targetPath, 'my_plugin')),
    Shell.cp('$_staticPath/', _targetPath),
    () async {
      await Shell.mkdir(File(_targetMyPluginKtPath).parent.path);
      await Shell.cp(_sourceMyPluginKtPath, _targetMyPluginKtPath);
      await Shell.rm(File(_sourceMyPluginKtPath).parent.parent.path);
    }()
  ]);

  // Remove excluded files
  await Future.wait(
    excludedFiles.map((file) => File(file).delete(recursive: true)),
  );

  Future<void> fixConditional(String from, String to) async {
    Directory(to).createSync(recursive: true);
    await Shell.cp('$from/', '$to/');
    await Shell.rm(from);
  }

  // Add conditionals to platforms
  for (final platform in platforms) {
    // Make plugin platform dependencies conditional
    final platformPath = path.join(
      _targetPath,
      'my_plugin',
      'my_plugin_$platform',
    );
    final conditionalPlatformPath = path.join(
      _targetPath,
      'my_plugin',
      '{{#$platform}}my_plugin_$platform{{',
      '$platform}}',
    );
    await fixConditional(platformPath, conditionalPlatformPath);

    // Make the example platforms conditional
    final examplePlatform = path.join(
      _targetPath,
      'my_plugin',
      'my_plugin',
      'example',
      platform,
    );
    final conditionalExamplePlatform = path.join(
      _targetPath,
      'my_plugin',
      'my_plugin',
      'example',
      '{{#$platform}}$platform{{',
      '$platform}}',
    );
    await fixConditional(examplePlatform, conditionalExamplePlatform);

    // Make the workflow files conditional
    final workflowFile = File(
      path.join(_gitHubWorkflowsPath, 'my_plugin_$platform.yaml'),
    );
    File(path.join(
      _gitHubWorkflowsPath,
      '{{#$platform}}my_plugin_$platform.yaml{{',
      '$platform}}',
    ))
      ..createSync(recursive: true)
      ..writeAsBytesSync(workflowFile.readAsBytesSync());
    await workflowFile.delete();
  }

  final appTest = File(path.join(
    _targetPath,
    'my_plugin',
    'my_plugin',
    'example',
    'integration_test',
    'app_test.dart',
  ));

  appTest.writeAsStringSync(
    appTest
        .readAsStringSync()
        .replaceAll(
          "  if (isWeb) return 'Web';\n",
          "{{#web}}  if (isWeb) return 'Web';\n{{/web}}",
        )
        .replaceAll(
          "  if (Platform.isAndroid) return 'Android';\n",
          "{{#android}}  if (Platform.isAndroid) return 'Android';\n{{/android}}",
        )
        .replaceAll(
          "  if (Platform.isIOS) return 'iOS';\n",
          "{{#ios}}  if (Platform.isIOS) return 'iOS';\n{{/ios}}",
        )
        .replaceAll(
          "  if (Platform.isLinux) return 'Linux';\n",
          "{{#linux}}  if (Platform.isLinux) return 'Linux';\n{{/linux}}",
        )
        .replaceAll(
          "  if (Platform.isMacOS) return 'MacOS';\n",
          "{{#macos}}  if (Platform.isMacOS) return 'MacOS';\n{{/macos}}",
        )
        .replaceAll(
          "  if (Platform.isWindows) return 'Windows';\n",
          "{{#windows}}  if (Platform.isWindows) return 'Windows';\n{{/windows}}",
        )
        .replaceAll(
          'bool get isWeb => identical(0, 0.0);\n',
          '{{#web}}bool get isWeb => identical(0, 0.0);\n{{/web}}',
        ),
  );

  await Future.wait(
    Directory(_targetPath)
        .listSync(recursive: true)
        .whereType<File>()
        .map((_) async {
      var file = _;
      if (!file.existsSync()) return;

      if (path.basename(file.path) == 'LICENSE') {
        await file.delete(recursive: true);
        return;
      }

      if (path.isWithin(_gitHubWorkflowsPath, file.path)) {
        final contents = file.readAsStringSync();
        file.writeAsStringSync(contents.replaceAll('src/my_plugin/', ''));
      }

      if (path.basename(file.path) == 'dependabot.yaml') {
        file.writeAsStringSync(
          '''
version: 2
enable-beta-ecosystems: true
updates:
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "daily"
  - package-ecosystem: "pub"
    directory: "/"
    schedule:
      interval: "daily"''',
        );
      }

      // Template File Contents
      final contents =
          file.isAsset() ? await file.readAsBytes() : await file.readAsString();
      final templatedContents = (contents is String)
          ? contents
              .replaceAll('com.example.my_plugin', '{{org_name.dotCase()}}')
              .replaceAll('my_plugin', '{{project_name.snakeCase()}}')
              .replaceAll('my-plugin', '{{project_name.paramCase()}}')
              .replaceAll('MyPlugin', '{{project_name.pascalCase()}}')
              .replaceAll('myPlugin', '{{project_name.camelCase()}}')
              .replaceAll('MY_PLUGIN', '{{project_name.constantCase()}}')
              .replaceAll(
                'A very good Flutter federated plugin',
                '{{{description}}}',
              )
              .replaceAll(_pluginPlatforms, '{{> plugin_platforms.dart }}')
              .replaceAll(
                _pluginDependencies,
                '{{> plugin_dependencies.dart }}',
              )
              .replaceAll(
                'Copyright (c) 2022 Very Good Ventures',
                'Copyright (c) {{current_year}} Very Good Ventures',
              )
          : contents;
      file = templatedContents is String
          ? await file.writeAsString(templatedContents)
          : await file.writeAsBytes(templatedContents as List<int>);

      /// Template file paths
      final fileSegments = file.path.split('/').sublist(2);
      if (fileSegments
          .any((e) => e.contains('my_plugin') || e.contains('MyPlugin'))) {
        final newSegments = fileSegments.map((e) {
          return e
              .replaceAll('MyPlugin', '{{project_name.pascalCase()}}')
              .replaceAll('my_plugin', '{{project_name.snakeCase()}}');
        });
        final newPathSegment = newSegments.join('/');
        final newPath = path.join(_targetPath, newPathSegment);
        final newFile = File(newPath)..createSync(recursive: true);
        templatedContents is String
            ? newFile.writeAsStringSync(templatedContents)
            : newFile.writeAsBytesSync(templatedContents as List<int>);
        file = newFile;
      }
    }),
  );

  // Clean up top-level directories
  Directory(path.join(_targetPath, 'my_plugin')).deleteSync(recursive: true);
}

class Shell {
  static Future<void> cp(String source, String destination) {
    return _Cmd.run('cp', ['-rf', source, destination]);
  }

  static Future<void> rm(String source) {
    return _Cmd.run('rm', ['-rf', source]);
  }

  static Future<void> mkdir(String destination) {
    return _Cmd.run('mkdir', ['-p', destination]);
  }
}

class _Cmd {
  static Future<ProcessResult> run(
    String cmd,
    List<String> args, {
    bool throwOnError = true,
    String? processWorkingDir,
  }) async {
    final result = await Process.run(cmd, args,
        workingDirectory: processWorkingDir, runInShell: true);

    if (throwOnError) {
      _throwIfProcessFailed(result, cmd, args);
    }
    return result;
  }

  static void _throwIfProcessFailed(
    ProcessResult pr,
    String process,
    List<String> args,
  ) {
    if (pr.exitCode != 0) {
      final values = {
        'Standard out': pr.stdout.toString().trim(),
        'Standard error': pr.stderr.toString().trim()
      }..removeWhere((k, v) => v.isEmpty);

      String message;
      if (values.isEmpty) {
        message = 'Unknown error';
      } else if (values.length == 1) {
        message = values.values.single;
      } else {
        message = values.entries.map((e) => '${e.key}\n${e.value}').join('\n');
      }

      throw ProcessException(process, args, message, pr.exitCode);
    }
  }
}

extension on File {
  bool isAsset() {
    const extensions = {
      '.png',
      '.ico',
      '.svg',
      '.jpg',
      '.jpeg',
      '.mov',
      '.mp4',
      'mp3',
      '.wav',
      '.ttf'
    };
    final ext = path.extension(this.path);
    return extensions.contains(ext);
  }
}
