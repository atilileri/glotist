import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:glotist_app/core/theme/app_theme.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:glotist_app/features/onboarding/presentation/pages/onboarding_conversation_screen.dart';
import 'package:glotist_app/l10n/app_localizations.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_helpers.dart';

class MockChatRemoteDataSource extends Mock implements ChatRemoteDataSource {}

void main() {
  late MockChatRemoteDataSource mockChatDataSource;

  setUpAll(() async {
    await loadAppFonts();
  });

  setUp(() async {
    mockChatDataSource = MockChatRemoteDataSource();

    final getIt = GetIt.instance;
    if (getIt.isRegistered<ChatRemoteDataSource>()) {
      await getIt.unregister<ChatRemoteDataSource>();
    }
    getIt.registerSingleton<ChatRemoteDataSource>(mockChatDataSource);
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  Widget buildWidgetUnderTest({required ThemeMode themeMode}) {
    final themeCubit = createMockThemeCubit(initialState: themeMode);

    return BlocProvider<ThemeCubit>.value(
      value: themeCubit,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeMode == ThemeMode.light
            ? AppTheme.lightTheme
            : AppTheme.darkTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
        ],
        locale: const Locale('en'),
        home: const OnboardingConversationScreen(),
      ),
    );
  }

  group('OnboardingConversationScreen Golden Tests', () {
    testGoldens('OnboardingConversationScreen Theme Variations',
        (tester) async {
      final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 0.5)
        ..addScenario(
          'Light Mode',
          SizedBox(
            height: 800,
            width: 400,
            child: buildWidgetUnderTest(themeMode: ThemeMode.light),
          ),
        )
        ..addScenario(
          'Dark Mode',
          SizedBox(
            height: 800,
            width: 400,
            child: buildWidgetUnderTest(themeMode: ThemeMode.dark),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        surfaceSize: const Size(1200, 1200),
      );

      // Wait for the welcome message animation and rendering
      // The screen has initial animations for the welcome messages.
      await tester.pump(const Duration(seconds: 1));

      await screenMatchesGolden(
        tester,
        'onboarding_conversation_screen_themes',
      );
    });
  });
}
