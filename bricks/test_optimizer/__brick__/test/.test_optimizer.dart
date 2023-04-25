// GENERATED CODE - DO NOT MODIFY BY HAND
// Consider adding this file to your .gitignore.

{{#isFlutter}}import 'dart:io';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
{{/isFlutter}}{{^isFlutter}}import 'package:test/test.dart';{{/isFlutter}}

{{#tests}}import '{{{path}}}' as {{identifier}};
{{/tests}}
void main() {
{{#isFlutter}}  goldenFileComparator = _TestOptimizationAwareGoldenFileComparator({{{goldenThreshold}}});{{/isFlutter}}
{{#tests}}  group('{{{path}}}', () { {{identifier}}.main(); });
{{/tests}}}

{{#isFlutter}}
class _TestOptimizationAwareGoldenFileComparator extends LocalFileComparator {
  final List<String> goldenFilePaths;
  final double threshold;

  _TestOptimizationAwareGoldenFileComparator(this.threshold)
      : assert(threshold >= 0 && threshold <= 1),
        goldenFilePaths = _goldenFilePaths,
        super(_testFile);

  static Uri get _testFile {
    final basedir =
        (goldenFileComparator as LocalFileComparator).basedir.toString();
    return Uri.parse("$basedir/.test_optimizer.dart");
  }

  static List<String> get _goldenFilePaths =>
      Directory.fromUri((goldenFileComparator as LocalFileComparator).basedir)
          .listSync(recursive: true, followLinks: true)
          .whereType<File>()
          .map((file) => file.path)
          .where((path) => path.endsWith('.png'))
          .toList();

  @override
  Uri getTestUri(Uri key, int? version) {
    final keyString = key.path;
    return Uri.parse(goldenFilePaths
        .singleWhere((goldenFilePath) => goldenFilePath.endsWith(keyString)));
  }

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    if (!result.passed && result.diffPercent <= threshold) {
      log(
        'A difference of ${result.diffPercent * 100}% was found, but it is '
        'acceptable since it is not greater than the threshold of '
        '${threshold * 100}%',
      );

      return true;
    }

    if (!result.passed) {
      final error = await generateFailureOutput(result, golden, basedir);
      throw FlutterError(error);
    }
    return result.passed;
  }
}
{{/isFlutter}}