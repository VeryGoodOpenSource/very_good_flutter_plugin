import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  final coverageFilePath = 'coverage/lcov.info';
  final matches = Glob('**/$coverageFilePath');
  final outputLcovPath = path.join(Directory.current.path, coverageFilePath);
  File(outputLcovPath).createSync(recursive: true);

  final coverageFiles = matches.listSync().map((entity) => entity.path);

  final result = await Process.run('lcov', [
    for (final coverageFile in coverageFiles) ...[
      '--add-tracefile',
      coverageFile
    ],
    '--output-file',
    outputLcovPath
  ]);

  print(result.stdout);
}
