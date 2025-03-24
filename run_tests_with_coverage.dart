import 'dart:io';

void main() async {
  await checkAndTestModules(['domain', 'data', 'features']);
  await runIntegrationTest();
}

Future<void> checkAndTestModules(List<String> modules) async {
  final currentDirectory = Directory.current;

  // Ensure the script is executed in the root of a Flutter project
  if (!(await File('${currentDirectory.path}/pubspec.yaml').exists())) {
    print(
        'Error: Not in a Flutter project directory. Make sure to run this script in the root of the project.');
    return;
  }

  for (final module in modules) {
    final moduleDirectory = Directory('${currentDirectory.path}/$module');

    if (await moduleDirectory.exists()) {
      print('Checking module: $module');
      await _runTestsRecursively(moduleDirectory);
    } else {
      print('⚠️ Module not found: $module');
    }
  }
}

Future<void> runIntegrationTest() async {
  print('Running Integration test...');

  final result = await Process.run(
    'flutter',
    ['test', 'integration_test'],
    workingDirectory: './',
    runInShell: true,
  );

  if (result.exitCode != 0) {
    print('❌ Integration test failed');
    print(result.stdout);
    print(result.stderr);
  } else {
    print('✅ Integration test passed');
  }
}

Future<void> _runTestsRecursively(Directory directory) async {
  // Exclude directories like .dart_tool, build, etc.
  const excludedDirectories = {
    '.dart_tool',
    'build',
    '.idea',
    '.vscode',
    '.git',
    'generated'
  };

  final subDirectories = directory
      .listSync(recursive: false)
      .whereType<Directory>()
      .where((dir) => !excludedDirectories
          .contains(dir.path.split(Platform.pathSeparator).last))
      .toList();

  // Check if the current directory contains tests
  final testDirectory = Directory('${directory.path}/test');
  if (await testDirectory.exists()) {
    print('Running tests in: ${directory.path}');
    final result = await Process.run(
      'flutter',
      ['test', '--coverage'],
      workingDirectory: directory.path,
      runInShell: true,
    );

    if (result.exitCode == 0) {
      await Process.run(
        'genhtml',
        ['coverage/lcov.info', '--output=coverage/report'],
        workingDirectory: directory.path,
        runInShell: true,
      );
      print('✅ Tests passed for: ${directory.path}');
    } else {
      print('❌ Tests failed for: ${directory.path}');
      print(result.stdout);
      print(result.stderr);
    }
  }

  // Recursively check all subdirectories
  for (final subDir in subDirectories) {
    await _runTestsRecursively(subDir);
  }
}
