// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:glotist_app/main.dart';

void main() {
  testWidgets('Onboarding screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GlotistApp());

    // Verify that the language selection screen is shown by searching
    // for its title
    expect(find.text('Pick your languages'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);

    // Verify 'STEP 1 OF 3' and other key elements are present
    expect(find.text('STEP 1 OF 3'), findsOneWidget);
  });
}
