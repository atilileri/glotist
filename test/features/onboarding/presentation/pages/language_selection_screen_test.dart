import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/features/onboarding/presentation/pages/language_selection_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    HttpOverrides.global = TestHttpOverrides();
    registerFallbackValue(Uri());
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
    expect(find.text('Japanese'), findsOneWidget);

    // Verify Japanese is selected (look for check circle near it)
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets('changes target language selection', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Initial state: Japanese selected
    expect(find.text('Japanese'), findsOneWidget);

    // Find Italian card and tap it
    final italianFinder = find.byKey(const ValueKey('lang_Italian'));
    await tester.scrollUntilVisible(
      italianFinder,
      50,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(italianFinder);
    await tester.pumpAndSettle();

    // Verify Italian is now selected
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });
}

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      createMockImageHttpClient(context);
}

HttpClient createMockImageHttpClient(SecurityContext? _) {
  final client = MockHttpClient();
  final request = MockHttpClientRequest();
  final response = MockHttpClientResponse();
  final headers = MockHttpHeaders();

  when(() => client.getUrl(any())).thenAnswer((_) async => request);
  when(() => request.headers).thenReturn(headers);
  when(request.close).thenAnswer((_) async => response);
  when(() => response.statusCode).thenReturn(HttpStatus.ok);
  when(() => response.contentLength).thenReturn(_transparentImage.length);
  when(() => response.compressionState)
      .thenReturn(HttpClientResponseCompressionState.notCompressed);
  when(
    () => response.listen(
      any(),
      cancelOnError: any(named: 'cancelOnError'),
      onDone: any(named: 'onDone'),
      onError: any(named: 'onError'),
    ),
  ).thenAnswer((invocation) {
    final onData =
        invocation.positionalArguments[0] as void Function(List<int>);
    final onDone = invocation.namedArguments[#onDone] as void Function()?;
    return Stream<List<int>>.fromIterable([_transparentImage]).listen(
      onData,
      onDone: onDone,
    );
  });

  return client;
}

final List<int> _transparentImage = [
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
];
