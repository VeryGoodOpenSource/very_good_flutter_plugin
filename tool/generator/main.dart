import 'dart:io';
import 'package:path/path.dart' as path;

final _sourcePath = path.join('src');
final _targetPath = path.join('brick', '__brick__');
final year = DateTime.now().year;
final copyrightHeader = '''
// Copyright (c) $year, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
''';

void main() async {
  // Remove Previously Generated Files
  final targetDir = Directory(_targetPath);
  if (targetDir.existsSync()) {
    await targetDir.delete(recursive: true);
  }

  // Copy Project Files
  await Shell.cp(_sourcePath, _targetPath);

  await Future.wait(
    Directory(_targetPath)
        .listSync(recursive: true)
        .whereType<File>()
        .map((_) async {
      var file = _;
      if (!file.existsSync()) return;
      if (file.isAsset()) return;

      // Add copyright header to all .dart files
      if (path.extension(file.path) == '.dart') {
        final contents = await file.readAsString();
        file = await file.writeAsString('$copyrightHeader\n$contents');
      }

      // Template File Contents
      final contents = await file.readAsString();
      final templatedContents = contents
          .replaceAll(
            'my_plugin',
            '{{#snakeCase}}{{project_name}}{{/snakeCase}}',
          )
          .replaceAll(
            'my-plugin',
            '{{#paramCase}}{{project_name}}{{/paramCase}}',
          )
          .replaceAll(
            'MyPlugin',
            '{{#pascalCase}}{{project_name}}{{/pascalCase}}',
          )
          .replaceAll(
            'A very good Flutter federated plugin',
            '{{{description}}}',
          );
      file = await file.writeAsString(templatedContents);

      /// Template file paths
      final fileSegments = file.path.split('/').sublist(2);
      if (fileSegments.any((e) => e.contains('my_plugin'))) {
        final newPathSegment = fileSegments.join('/').replaceAll(
              'my_plugin',
              '{{#snakeCase}}{{project_name}}{{/snakeCase}}',
            );
        final newPath = path.join(_targetPath, newPathSegment);
        final newFile = File(newPath)..createSync(recursive: true);
        newFile.writeAsStringSync(templatedContents);
        file = newFile;
      }
    }),
  );

  // Clean up top-level directories
  const topLevelDirs = [
    'my_plugin',
    'my_plugin_android',
    'my_plugin_ios',
    'my_plugin_linux',
    'my_plugin_macos',
    'my_plugin_platform_interface',
    'my_plugin_web',
    'my_plugin_windows',
  ];
  for (final dir in topLevelDirs) {
    Directory(path.join(_targetPath, dir)).deleteSync(recursive: true);
  }
}

class Shell {
  static Future<void> cp(String source, String destination) {
    return _Cmd.run('cp', ['-rf', source, destination]);
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
