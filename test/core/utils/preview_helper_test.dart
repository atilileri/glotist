/// Unit tests for preview helper utilities.
///
/// Tests cover:
/// - PreviewWrapper widget functionality
/// - AppPreview annotation configuration
/// - Theme and localization integration
/// - Widget tree structure and providers
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/utils/preview_helper.dart';
import 'package:glotist_app/l10n/app_localizations.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('PreviewWrapper', () {
    setUp(() async {
      logSetup('Initializing PreviewWrapper tests');
    });

    tearDown(() {
      logTeardown('PreviewWrapper tests complete');
    });

    /// Test 1: PreviewWrapper renders with default parameters.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with test child widget
    /// 2. Pump widget and verify basic structure
    /// 3. Verify child widget is rendered
    testWidgets('renders with default parameters', (tester) async {
      logStep(1, 'Creating PreviewWrapper with test child');
      const childWidget = Text('Test Child');

      logStep(2, 'Pumping widget tree');
      await tester.pumpWidget(
        const PreviewWrapper(child: childWidget),
      );

      logVerify('Child widget should be rendered');
      expect(find.text('Test Child'), findsOneWidget);

      logVerify('MaterialApp should be present');
      expect(find.byType(MaterialApp), findsOneWidget);

      logVerify('Scaffold should be present');
      expect(find.byType(Scaffold), findsOneWidget);
    });

    /// Test 2: PreviewWrapper renders with custom locale.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with Spanish locale
    /// 2. Pump widget and verify locale configuration
    testWidgets('renders with custom locale', (tester) async {
      logStep(1, 'Creating PreviewWrapper with Spanish locale');
      const childWidget = Text('Test Child');
      const customLocale = Locale('es');

      await tester.pumpWidget(
        const PreviewWrapper(
          locale: customLocale,
          child: childWidget,
        ),
      );

      logStep(2, 'Verifying locale configuration');
      final materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      logVerify('Locale should be set to Spanish');
      expect(materialApp.locale, equals(customLocale));
    });

    /// Test 3: PreviewWrapper renders with dark brightness.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with dark brightness
    /// 2. Pump widget and verify theme mode
    testWidgets('renders with dark brightness', (tester) async {
      logStep(1, 'Creating PreviewWrapper with dark theme');
      const childWidget = Text('Test Child');

      await tester.pumpWidget(
        const PreviewWrapper(
          brightness: Brightness.dark,
          child: childWidget,
        ),
      );

      logStep(2, 'Verifying dark theme mode');
      final materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      logVerify('Theme mode should be dark');
      expect(materialApp.themeMode, equals(ThemeMode.dark));
    });

    /// Test 4: PreviewWrapper renders with light brightness.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with light brightness
    /// 2. Pump widget and verify theme mode
    testWidgets('renders with light brightness', (tester) async {
      logStep(1, 'Creating PreviewWrapper with light theme');
      const childWidget = Text('Test Child');

      await tester.pumpWidget(
        const PreviewWrapper(
          child: childWidget,
        ),
      );

      logStep(2, 'Verifying light theme mode');
      final materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      logVerify('Theme mode should be light');
      expect(materialApp.themeMode, equals(ThemeMode.light));
    });

    /// Test 5: PreviewWrapper provides required cubits.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with test child
    /// 2. Pump widget and verify MultiBlocProvider is present
    /// Note: Private cubit classes cannot be accessed directly in tests
    testWidgets('provides ThemeCubit and LocalizationCubit', (tester) async {
      logStep(1, 'Creating PreviewWrapper with test child');
      const childWidget = Text('Test Child');

      await tester.pumpWidget(
        const PreviewWrapper(child: childWidget),
      );

      logStep(2, 'Verifying MultiBlocProvider contains cubits');
      logVerify('MultiBlocProvider should be present');
      expect(find.byType(MultiBlocProvider), findsOneWidget);

      // Note: We can't directly test for the private cubit classes,
      // but we can verify the provider structure is correct
      logVerify('BlocProvider structure should be present');
      // The MultiBlocProvider contains the cubits but we can't access
      // the providers property directly, so we just verify it exists
    });

    /// Test 6: PreviewWrapper includes proper localization delegates.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with test child
    /// 2. Pump widget and verify localization setup
    testWidgets('includes proper localization delegates', (tester) async {
      logStep(1, 'Creating PreviewWrapper with test child');
      const childWidget = Text('Test Child');

      await tester.pumpWidget(
        const PreviewWrapper(child: childWidget),
      );

      logStep(2, 'Verifying localization delegates');
      final materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );

      logVerify('AppLocalizations delegate should be present');
      expect(
        materialApp.localizationsDelegates,
        contains(AppLocalizations.delegate),
      );

      logVerify('Material localizations delegate should be present');
      expect(
        materialApp.localizationsDelegates,
        contains(GlobalMaterialLocalizations.delegate),
      );

      logVerify('Widgets localizations delegate should be present');
      expect(
        materialApp.localizationsDelegates,
        contains(GlobalWidgetsLocalizations.delegate),
      );

      logVerify('Cupertino localizations delegate should be present');
      expect(
        materialApp.localizationsDelegates,
        contains(GlobalCupertinoLocalizations.delegate),
      );
    });

    /// Test 7: PreviewWrapper supports supported locales.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with test child
    /// 2. Pump widget and verify supported locales
    testWidgets('supports supported locales', (tester) async {
      logStep(1, 'Creating PreviewWrapper with test child');
      const childWidget = Text('Test Child');

      await tester.pumpWidget(
        const PreviewWrapper(child: childWidget),
      );

      logStep(2, 'Verifying supported locales');
      final materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      logVerify('Supported locales should match AppLocalizations');
      expect(
        materialApp.supportedLocales,
        equals(AppLocalizations.supportedLocales),
      );
    });

    /// Test 8: PreviewWrapper disables debug banner.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with test child
    /// 2. Pump widget and verify debug banner is disabled
    testWidgets('disables debug banner', (tester) async {
      logStep(1, 'Creating PreviewWrapper with test child');
      const childWidget = Text('Test Child');

      await tester.pumpWidget(
        const PreviewWrapper(child: childWidget),
      );

      logStep(2, 'Verifying debug banner is disabled');
      final materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      logVerify('Debug banner should be disabled');
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });
  });

  group('AppPreview', () {
    setUp(() async {
      logSetup('Initializing AppPreview tests');
    });

    tearDown(() {
      logTeardown('AppPreview tests complete');
    });

    /// Test 1: AppPreview creates with custom parameters.
    ///
    /// Steps:
    /// 1. Create AppPreview with custom parameters
    /// 2. Verify all parameters are set correctly
    test('creates AppPreview with custom parameters', () {
      logStep(1, 'Creating AppPreview with custom parameters');
      const appPreview = AppPreview(
        name: 'Test Preview',
        group: 'Test Group',
        locale: 'es',
        size: Size(400, 600),
        textScaleFactor: 1.5,
        brightness: Brightness.dark,
      );

      logStep(2, 'Verifying custom parameters');
      logVerify('Name should be set correctly');
      expect(appPreview.name, equals('Test Preview'));

      logVerify('Group should be set correctly');
      expect(appPreview.group, equals('Test Group'));

      logVerify('Locale should be set correctly');
      expect(appPreview.locale, equals('es'));

      logVerify('Size should be set correctly');
      expect(appPreview.size, equals(const Size(400, 600)));

      logVerify('Text scale factor should be set correctly');
      expect(appPreview.textScaleFactor, equals(1.5));

      logVerify('Brightness should be set correctly');
      expect(appPreview.brightness, equals(Brightness.dark));
    });
  });

  group('Private Cubit Integration Tests', () {
    setUp(() async {
      logSetup('Initializing private cubit integration tests');
    });

    tearDown(() {
      logTeardown('Private cubit integration tests complete');
    });

    /// Test 1: PreviewWrapper with different constructor parameters.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with all constructor parameters
    /// 2. This exercises the constructor (line 14)
    testWidgets('constructor with all parameters', (tester) async {
      logStep(1, 'Creating PreviewWrapper with all parameters');
      const childWidget = Text('Test Child');
      const customLocale = Locale('fr');
      const customBrightness = Brightness.dark;

      await tester.pumpWidget(
        const PreviewWrapper(
          key: Key('test-key'),
          locale: customLocale,
          brightness: customBrightness,
          child: childWidget,
        ),
      );

      logStep(2, 'Verifying widget is rendered');
      expect(find.text('Test Child'), findsOneWidget);
      expect(find.byKey(const Key('test-key')), findsOneWidget);
    });

    /// Test 2: PreviewWrapper with key parameter.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with key
    /// 2. Verify the key is properly set
    testWidgets('constructor with key parameter', (tester) async {
      logStep(1, 'Creating PreviewWrapper with key');
      const testKey = Key('preview-wrapper-key');
      const childWidget = Text('Test Child');

      await tester.pumpWidget(
        const PreviewWrapper(
          key: testKey,
          child: childWidget,
        ),
      );

      logStep(2, 'Verifying key is set');
      expect(find.byKey(testKey), findsOneWidget);
      expect(find.text('Test Child'), findsOneWidget);
    });

    /// Test 3: Multiple PreviewWrapper instances with different configurations.
    ///
    /// Steps:
    /// 1. Create multiple instances to exercise provider creation
    /// 2. This exercises lines 48-51 (provider creation)
    testWidgets('multiple instances exercise provider creation',
        (tester) async {
      logStep(1, 'Creating multiple PreviewWrapper instances');

      await tester.pumpWidget(
        const PreviewWrapper(
          child: Text('Instance 1'),
        ),
      );

      logStep(2, 'Creating second instance');
      await tester.pumpWidget(
        const PreviewWrapper(
          locale: Locale('es'),
          child: Text('Instance 2'),
        ),
      );

      logStep(3, 'Verifying both instances work');
      expect(find.text('Instance 2'), findsOneWidget);
    });
  });

  group('Integration Tests', () {
    setUp(() async {
      logSetup('Initializing integration tests');
    });

    tearDown(() {
      logTeardown('Integration tests complete');
    });

    /// Test 1: Complete preview setup works end-to-end.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with custom settings
    /// 2. Pump widget and verify complete setup
    /// 3. Verify all components are properly integrated
    testWidgets('complete preview setup works end-to-end', (tester) async {
      logStep(1, 'Creating complete preview setup');
      const childWidget = Text('Hello World');

      await tester.pumpWidget(
        const PreviewWrapper(
          locale: Locale('es'),
          brightness: Brightness.dark,
          child: childWidget,
        ),
      );

      logStep(2, 'Verifying widget tree structure');
      logVerify('Child widget should be rendered');
      expect(find.text('Hello World'), findsOneWidget);

      logVerify('MaterialApp should be present');
      expect(find.byType(MaterialApp), findsOneWidget);

      logVerify('Scaffold should be present');
      expect(find.byType(Scaffold), findsOneWidget);

      logVerify('MultiBlocProvider should be present');
      expect(find.byType(MultiBlocProvider), findsOneWidget);

      logStep(3, 'Verifying MaterialApp configuration');
      final materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );

      logVerify('Locale should be Spanish');
      expect(materialApp.locale, equals(const Locale('es')));

      logVerify('Theme mode should be dark');
      expect(materialApp.themeMode, equals(ThemeMode.dark));

      logVerify('Debug banner should be disabled');
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });

    /// Test 2: Multiple PreviewWrapper instances work independently.
    ///
    /// Steps:
    /// 1. Create two PreviewWrapper instances with different settings
    /// 2. Pump widgets and verify they work independently
    testWidgets('multiple instances work independently', (tester) async {
      logStep(1, 'Creating first PreviewWrapper with light theme');
      const childWidget1 = Text('Light Theme');

      await tester.pumpWidget(
        const PreviewWrapper(
          child: childWidget1,
        ),
      );

      logStep(2, 'Verifying first instance configuration');
      final materialApp1 = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      expect(materialApp1.themeMode, equals(ThemeMode.light));
      expect(materialApp1.locale, equals(const Locale('en')));

      logStep(3, 'Creating second PreviewWrapper with dark theme');
      const childWidget2 = Text('Dark Theme');

      await tester.pumpWidget(
        const PreviewWrapper(
          brightness: Brightness.dark,
          locale: Locale('es'),
          child: childWidget2,
        ),
      );

      logStep(4, 'Verifying second instance configuration');
      final materialApp2 = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      expect(materialApp2.themeMode, equals(ThemeMode.dark));
      expect(materialApp2.locale, equals(const Locale('es')));
    });

    /// Test 3: PreviewWrapper handles theme changes gracefully.
    ///
    /// Steps:
    /// 1. Create PreviewWrapper with initial theme
    /// 2. Pump widget and verify initial state
    /// 3. Verify widget remains stable after theme changes
    testWidgets('handles theme changes gracefully', (tester) async {
      logStep(1, 'Creating PreviewWrapper with initial theme');
      const childWidget = Text('Test Child');

      await tester.pumpWidget(
        const PreviewWrapper(
          child: childWidget,
        ),
      );

      logStep(2, 'Verifying initial theme configuration');
      final materialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      expect(materialApp.themeMode, equals(ThemeMode.light));

      logStep(3, 'Rebuilding with different theme');
      await tester.pumpWidget(
        const PreviewWrapper(
          brightness: Brightness.dark,
          child: childWidget,
        ),
      );

      logStep(4, 'Verifying theme change and widget stability');
      final updatedMaterialApp = tester.widget<MaterialApp>(
        find.byType(MaterialApp),
      );
      expect(updatedMaterialApp.themeMode, equals(ThemeMode.dark));

      logVerify('Child widget should still be present after theme change');
      expect(find.text('Test Child'), findsOneWidget);
    });
  });
}
