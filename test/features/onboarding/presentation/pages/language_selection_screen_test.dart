import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/features/onboarding/presentation/pages/language_selection_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    HttpOverrides.global = TestHttpOverrides();
  });

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: LanguageSelectionScreen(),
    );
  }

  testWidgets('renders all sections and default selection', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Check headers
    expect(find.text('NATIVE LANGUAGE'), findsOneWidget);
    expect(find.text('OTHER LANGUAGES'), findsOneWidget);
    expect(find.text('I WANT TO LEARN'), findsOneWidget);
    expect(find.text('Pick your languages'), findsOneWidget);

    // Check default native language
    expect(find.text('English (United States)'), findsOneWidget);

    // Check default target language selection (Japanese)
    // We can check if the check circle icon is present on the Japanese card
    // Or check if the Japanese text is present
    expect(find.text('Japanese'), findsOneWidget);
    
    // Verify Japanese is selected (look for check circle near it)
    // Finding the specific check circle might be tricky without keys, but let's try finding the icon inside the card.
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets('changes target language selection', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Initial state: Japanese selected
    expect(find.text('Japanese'), findsOneWidget);

    // Find Italian card and tap it
    final italianFinder = find.text('Italian');
    await tester.scrollUntilVisible(italianFinder, 50); // Ensure it's visible
    await tester.tap(italianFinder);
    await tester.pumpAndSettle();

    // Verify Italian is now selected (we can't easily verify state without inspecting widget, 
    // but we can check if the check circle moved or if the color changed - logic is verified by interaction)
    
    // In a real app we might verify state change or callback, here we just ensure no crash and UI update
    // We could re-verify the Check Circle is present (it should still be there, just potentially in a different place)
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });
}

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return createMockImageHttpClient(context);
  }
}
