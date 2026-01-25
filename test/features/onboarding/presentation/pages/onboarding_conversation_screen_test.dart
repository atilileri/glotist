import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:glotist_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:glotist_app/features/chat/domain/entities/message.dart';
import 'package:glotist_app/features/onboarding/presentation/pages/onboarding_conversation_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockChatRemoteDataSource extends Mock implements ChatRemoteDataSource {}

void main() {
  late MockChatRemoteDataSource mockChatDataSource;

  setUp(() {
    mockChatDataSource = MockChatRemoteDataSource();
    final getIt = GetIt.instance;
    if (getIt.isRegistered<ChatRemoteDataSource>()) {
      getIt.unregister<ChatRemoteDataSource>();
    }
    getIt.registerSingleton<ChatRemoteDataSource>(mockChatDataSource);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: OnboardingConversationScreen(),
    );
  }

  testWidgets('renders initial system message', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle(); // Wait for any initial animations if any

    expect(
        find.text(
            "Hello! I'm your Onboarding Agent. Let's create your personalized curriculum. What languages do you know?"),
        findsOneWidget);
    expect(find.text('Onboarding Assistant'), findsOneWidget);
  });

  testWidgets('sends message and shows response', (tester) async {
    final responseMessage = Message(
      id: 'response-id',
      content: 'That sounds great!',
      isUser: false,
      timestamp: DateTime.now(),
    );

    when(() => mockChatDataSource.sendMessage(any()))
        .thenAnswer((_) async => responseMessage);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final inputFinder = find.byType(TextField);
    final sendButtonFinder = find.byIcon(Icons.send);

    // Enter text
    await tester.enterText(inputFinder, 'I know English and Spanish');
    await tester.pump();

    // Tap send
    await tester.tap(sendButtonFinder);
    await tester.pump(); // Start loading

    await tester.pumpAndSettle(); // Wait for response

    // Verify user message is shown
    expect(find.text('I know English and Spanish'), findsOneWidget);

    // Verify response is shown
    expect(find.text('That sounds great!'), findsOneWidget);
  });
}
