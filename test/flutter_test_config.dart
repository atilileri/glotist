import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// Global test configuration for Flutter tests.
///
/// This file is automatically picked up by `flutter test` and allows
/// configuring the test environment.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  if (goldenFileComparator is LocalFileComparator) {
    final prevComparator = goldenFileComparator as LocalFileComparator;
    goldenFileComparator = ThresholdGoldenComparator(
      Uri.parse(prevComparator.basedir.toString()),
    );
  }
  await testMain();
}

/// A [GoldenFileComparator] that allows a specific [threshold] for differences.
///
/// This is useful for running golden tests across different environments
/// (e.g., local vs. CI) where small pixel differences are expected.
class ThresholdGoldenComparator extends LocalFileComparator {
  ThresholdGoldenComparator(super.testFile, {this.threshold = 0.015});
  final double threshold;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    if (result.passed || result.diffPercent <= threshold) {
      return true;
    }

    final error = await generateFailureOutput(result, golden, basedir);
    throw FlutterError(error);
  }
}
