import 'dart:io';

import 'package:mason/mason.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

/// The name of the pubspec.yaml file.
///
/// We assume that if a pubspec.yaml file exists, then the project is a Dart
/// project.
const _pubspecYamlFileName = 'pubspec.yaml';

/// Type definition for [Process.run].
typedef RunProcess = Future<ProcessResult> Function(
  String executable,
  List<String> arguments, {
  String? workingDirectory,
  bool runInShell,
});

Future<void> run(HookContext context,
// We intentionally ignore the trailing comma until the following mason issue is
// fixed: https://github.com/felangel/mason/issues/1169
// ignore: require_trailing_commas
    {@visibleForTesting RunProcess runProcess = Process.run}) async {
  final progress = context.logger.progress('Getting Flutter dependencies');

  final projects =
      Directory.current.listSync(recursive: true).whereType<File>().where(
            (file) => file.path.endsWith(_pubspecYamlFileName),
          );

  for (final project in projects) {
    final projectPath =
        path.dirname(path.relative(project.path, from: Directory.current.path));

    progress.update('Getting Flutter dependencies ($projectPath)');

    // We have to `pub get` the generated project to ensure that the analysis
    // is able to fix the imports with the correct analysis options.
    await runProcess(
      'flutter',
      [
        'pub',
        'get',
        '--directory=$projectPath',
      ],
      workingDirectory: Directory.current.path,
    );
  }

  progress.update('Fixing Dart imports ordering...');

  // Some imports are relative to the user specified package name, hence
  // we try to fix the import directive ordering after the template has
  // been generated.
  //
  // We only fix for the [directives_ordering](https://dart.dev/tools/linter-rules/directives_ordering)
  // linter rules, as the other rule should be tackled by the template itself.
  await runProcess(
    'dart',
    [
      'fix',
      '--apply',
      '--code=directives_ordering',
    ],
    workingDirectory: Directory.current.path,
  );

  progress.complete('Completed post-generation');
}
