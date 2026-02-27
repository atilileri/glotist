import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:glotist_app/core/presentation/widgets/chat_input_bar.dart';
import 'package:glotist_app/core/presentation/widgets/chat_message_bubble.dart';
import 'package:glotist_app/core/presentation/widgets/onboarding_substep_indicator.dart';
import 'package:glotist_app/core/presentation/widgets/onboarding_top_bar.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:glotist_app/features/chat/domain/entities/message.dart';
import 'package:glotist_app/features/onboarding/presentation/pages/onboarding_conversation_screen.dart';
import 'package:glotist_app/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_helpers.dart';

class MockChatRemoteDataSource extends Mock implements ChatRemoteDataSource {}

void main() {
  late MockChatRemoteDataSource mockChatDataSource;
  late MockThemeCubit mockThemeCubit;

  setUp(() async {
    mockChatDataSource = MockChatRemoteDataSource();
    mockThemeCubit = createMockThemeCubit();

    final getIt = GetIt.instance;
    if (getIt.isRegistered<ChatRemoteDataSource>()) {
      await getIt.unregister<ChatRemoteDataSource>();
    }
    getIt.registerSingleton<ChatRemoteDataSource>(mockChatDataSource);
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  Widget createWidgetUnderTest({Locale locale = const Locale('en')}) {
    return BlocProvider<ThemeCubit>.value(
      value: mockThemeCubit,
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('fr'),
          Locale('tr'),
          Locale('de'),
          Locale('nl'),
        ],
        locale: locale,
        home: const OnboardingConversationScreen(),
      ),
    );
  }

  group('OnboardingConversationScreen', () {
    testWidgets('renders all key UI elements', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      // Wait for the initial 800ms welcome message timer
      // TODO(atilileri): remove this after refactoring welcome timer
      await tester.pump(const Duration(seconds: 1));

      logVerify('Should render OnboardingTopBar with Profile Setup title');
      expect(find.byType(OnboardingTopBar), findsOneWidget);
      expect(find.text('Profile Setup'), findsOneWidget);

      logVerify('Should render Skip button');
      expect(find.text('Skip'), findsOneWidget);

      logVerify('Should render OnboardingSubstepIndicator');
      expect(find.byType(OnboardingSubstepIndicator), findsOneWidget);
      expect(find.text('Interests'), findsOneWidget);
      expect(find.text('Level'), findsOneWidget);
      expect(find.text('Purpose'), findsOneWidget);

      logVerify('Should render initial AI messages');
      expect(find.byType(ChatMessageBubble), findsWidgets);
      expect(
        find.text("Let's make sure I teach you what you care about."),
        findsOneWidget,
      );

      logVerify('Should render ChatInputBar');
      expect(find.byType(ChatInputBar), findsOneWidget);
      expect(find.text('Type a message...'), findsOneWidget);
    });

    testWidgets('sends message and shows user bubble', (tester) async {
      final responseMessage = Message(
        id: 'response-id',
        content: 'That sounds great!',
        isUser: false,
        timestamp: DateTime.now(),
      );

      when(() => mockChatDataSource.sendMessage(any()))
          .thenAnswer((_) async => responseMessage);

      await tester.pumpWidget(createWidgetUnderTest());
      // Wait for the initial 800ms welcome message timer
      // TODO(atilileri): remove this after refactoring welcome timer
      await tester.pump(const Duration(seconds: 1));

      logAction('Entering text in input');
      final inputFinder = find.byType(TextField);
      await tester.enterText(inputFinder, 'I love cooking');
      await tester.pump();

      logAction('Tapping send button');
      final sendButton = find.byIcon(Icons.send);
      await tester.tap(sendButton);
      await tester.pump();

      logVerify('User message should appear');
      expect(find.text('I love cooking'), findsOneWidget);

      logVerify('Should show typing indicator while loading');
      expect(find.text('TYPING...'), findsOneWidget);

      // Wait for the 5-second delay + response
      // TODO(atilileri): remove this after testing typing indicator
      await tester.pump(const Duration(seconds: 6));

      logVerify('AI response should appear');
      expect(find.text('That sounds great!'), findsOneWidget);
    });

    testWidgets('renders correctly with German locale', (tester) async {
      await tester
          .pumpWidget(createWidgetUnderTest(locale: const Locale('de')));
      // Wait for the initial 800ms welcome message timer
      // TODO(atilileri): remove this after refactoring welcome timer
      await tester.pump(const Duration(seconds: 1));

      logVerify('Should render German localized strings');
      expect(find.text('Profil einrichten'), findsOneWidget);
      expect(find.text('Überspringen'), findsOneWidget);
      expect(find.text('Interessen'), findsOneWidget);
      expect(find.text('Niveau'), findsOneWidget);
      expect(find.text('Zweck'), findsOneWidget);
      expect(find.text('Nachricht eingeben...'), findsOneWidget);
    });

    testWidgets('renders without errors in dark theme', (tester) async {
      final darkThemeCubit = createMockThemeCubit(
        initialState: ThemeMode.dark,
      );

      await tester.pumpWidget(
        BlocProvider<ThemeCubit>.value(
          value: darkThemeCubit,
          child: MaterialApp(
            theme: ThemeData.dark(useMaterial3: true),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en')],
            locale: const Locale('en'),
            home: const OnboardingConversationScreen(),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      logVerify('Screen should render without errors in dark theme');
      expect(find.byType(OnboardingConversationScreen), findsOneWidget);
      expect(find.text('Profile Setup'), findsOneWidget);
    });

    testWidgets('shows status chip on user messages', (tester) async {
      final responseMessage = Message(
        id: 'response-id',
        content: 'Noted!',
        isUser: false,
        timestamp: DateTime.now(),
      );

      when(() => mockChatDataSource.sendMessage(any()))
          .thenAnswer((_) async => responseMessage);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(seconds: 1));

      logAction('Sending first message');
      await tester.enterText(find.byType(TextField), 'I love cooking');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      logVerify('First user message should have INTERESTS NOTED status');
      expect(find.text('INTERESTS NOTED'), findsOneWidget);

      // Clear timers and allow animations to settle for a bit before ending
      await tester.pump(const Duration(seconds: 6));
    });
  });
}
