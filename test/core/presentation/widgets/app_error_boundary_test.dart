import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/presentation/widgets/app_error_boundary.dart';

void main() {
  testWidgets('AppErrorBoundary displays fallback UI for errors',
      (tester) async {
    // Create mock error details
    final errorDetails = FlutterErrorDetails(
      exception: Exception('Intended test exception'),
      library: 'glotist_test',
    );

    // Pump the boundary widget directly
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppErrorBoundary(details: errorDetails),
        ),
      ),
    );

    // Wait for the UI to settle
    await tester.pumpAndSettle();

    // Verify the user-facing message is displayed
    expect(find.text('Oops! Something went wrong.'), findsOneWidget);
    expect(
      find.text('An unexpected rendering error occurred.'),
      findsOneWidget,
    );

    // Verify the technical details are displayed (since tests run in debug
    // mode)
    expect(find.textContaining('Intended test exception'), findsOneWidget);
  });
}
