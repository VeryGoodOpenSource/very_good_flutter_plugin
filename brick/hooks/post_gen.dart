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
// TODO(alestiago): We intentionally ignore the trailing comma until
// the following mason issue is fixed: https://github.com/felangel/mason/issues/1169
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

  progress.update('Fixing Dart imports ordering');
  await _fixDirectivesOrdering(runProcess: runProcess);

  progress.update('Fixing long lines');
  await _fixLinesLongerThan80Chars(runProcess: runProcess);

  progress.complete('Completed post-generation');
}

/// Fixes, using `dart fix`, the ordering of the Dart imports.
///
/// Some imports are relative to the user specified package name, hence
/// we try to fix the import directive ordering after the template has
/// been generated to avoid analysis issues.
///
/// We explicitly fix for the [directives_ordering](https://dart.dev/tools/linter-rules/directives_ordering)
/// linter rules, as other rules should be tackled by the template itself.
Future<ProcessResult> _fixDirectivesOrdering({
  required RunProcess runProcess,
}) async {
  return runProcess(
    'dart',
    [
      'fix',
      '--apply',
      '--code=directives_ordering',
    ],
    workingDirectory: Directory.current.path,
  );
}

/// Fixes, using `dart format`, the lines longer than 80 characters.
///
/// Some lines are relative to the user specified package name, hence if the
/// name is sufficiently long it will break the 80 characters limit.
///
/// We explicitly fix for the [lines_longer_than_80_chars](https://dart.dev/tools/linter-rules/lines_longer_than_80_chars)
/// linter rules, as other rules should be tackled by the template itself.
Future<ProcessResult> _fixLinesLongerThan80Chars({
  required RunProcess runProcess,
}) async {
  // TODO(alestiago): Should explicitly solve for the linter rule
  // `lines_longer_than_80_chars` as soon as the following issue is fixed:
  // https://github.com/dart-lang/dart_style/issues/1334
  return runProcess(
    'dart',
    [
      'format',
      '.',
    ],
    workingDirectory: Directory.current.path,
  );
}
