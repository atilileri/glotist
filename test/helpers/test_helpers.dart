/// Shared test utilities for Glotist test suite.
///
/// This file provides common helpers to eliminate code duplication across
/// tests.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// =============================================================================
// HTTP Overrides for Google Fonts
// =============================================================================

/// HTTP overrides to prevent network calls during tests (e.g., Google Fonts).
class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient();
  }
}

class _MockHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;

  @override
  Duration? connectionTimeout;

  @override
  Duration idleTimeout = const Duration(seconds: 15);

  @override
  int? maxConnectionsPerHost;

  @override
  String? userAgent;

  @override
  void addCredentials(
    Uri url,
    String realm,
    HttpClientCredentials credentials,
  ) {}

  @override
  void addProxyCredentials(
    String host,
    int port,
    String realm,
    HttpClientCredentials credentials,
  ) {}

  @override
  set authenticate(
    Future<bool> Function(Uri url, String scheme, String? realm)? f,
  ) {}

  @override
  set authenticateProxy(
    Future<bool> Function(String host, int port, String scheme, String? realm)?
        f,
  ) {}

  @override
  set badCertificateCallback(
    bool Function(X509Certificate cert, String host, int port)? callback,
  ) {}

  @override
  void close({bool force = false}) {}

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) {
    return _emptyRequest();
  }

  @override
  set findProxy(String Function(Uri url)? f) {}

  @override
  Future<HttpClientRequest> get(String host, int port, String path) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> getUrl(Uri url) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> head(String host, int port, String path) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> headUrl(Uri url) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> open(
    String method,
    String host,
    int port,
    String path,
  ) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> patchUrl(Uri url) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> post(String host, int port, String path) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> postUrl(Uri url) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> put(String host, int port, String path) {
    return _emptyRequest();
  }

  @override
  Future<HttpClientRequest> putUrl(Uri url) {
    return _emptyRequest();
  }

  @override
  set connectionFactory(
    Future<ConnectionTask<Socket>> Function(
      Uri url,
      String? proxyHost,
      int? proxyPort,
    )? f,
  ) {}

  @override
  set keyLog(void Function(String line)? callback) {}

  Future<HttpClientRequest> _emptyRequest() async {
    return _MockHttpClientRequest();
  }
}

class _MockHttpClientRequest implements HttpClientRequest {
  @override
  bool bufferOutput = true;

  @override
  int contentLength = -1;

  @override
  Encoding encoding = utf8;

  @override
  bool followRedirects = true;

  @override
  int maxRedirects = 5;

  @override
  bool persistentConnection = true;

  @override
  void abort([Object? exception, StackTrace? stackTrace]) {}

  @override
  void add(List<int> data) {}

  @override
  void addError(Object error, [StackTrace? stackTrace]) {}

  @override
  Future<void> addStream(Stream<List<int>> stream) async {}

  @override
  Future<HttpClientResponse> close() async {
    return _MockHttpClientResponse();
  }

  @override
  HttpConnectionInfo? get connectionInfo => null;

  @override
  List<Cookie> get cookies => [];

  @override
  Future<HttpClientResponse> get done async {
    return _MockHttpClientResponse();
  }

  @override
  Future<void> flush() async {}

  @override
  HttpHeaders get headers => _MockHttpHeaders();

  @override
  String get method => 'GET';

  @override
  Uri get uri => Uri.parse('http://localhost');

  @override
  void write(Object? object) {}

  @override
  void writeAll(Iterable<Object?> objects, [String separator = '']) {}

  @override
  void writeCharCode(int charCode) {}

  @override
  void writeln([Object? object = '']) {}
}

class _MockHttpClientResponse implements HttpClientResponse {
  @override
  X509Certificate? get certificate => null;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  HttpConnectionInfo? get connectionInfo => null;

  @override
  int get contentLength => 0;

  @override
  List<Cookie> get cookies => [];

  @override
  Future<Socket> detachSocket() async {
    throw UnsupportedError('Cannot detach socket from mock response');
  }

  @override
  HttpHeaders get headers => _MockHttpHeaders();

  @override
  bool get isRedirect => false;

  @override
  bool get persistentConnection => false;

  @override
  String get reasonPhrase => 'OK';

  @override
  Future<HttpClientResponse> redirect([
    String? method,
    Uri? url,
    bool? followLoops,
  ]) async {
    return this;
  }

  @override
  List<RedirectInfo> get redirects => [];

  @override
  int get statusCode => 200;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return const Stream<List<int>>.empty().listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Future<bool> any(bool Function(List<int> element) test) async => false;

  @override
  Stream<List<int>> asBroadcastStream({
    void Function(StreamSubscription<List<int>> subscription)? onListen,
    void Function(StreamSubscription<List<int>> subscription)? onCancel,
  }) {
    return const Stream.empty();
  }

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(List<int> event) convert) {
    return const Stream.empty();
  }

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(List<int> event) convert) {
    return const Stream.empty();
  }

  @override
  Stream<R> cast<R>() => const Stream.empty();

  @override
  Future<bool> contains(Object? needle) async => false;

  @override
  Stream<List<int>> distinct([
    bool Function(List<int> previous, List<int> next)? equals,
  ]) {
    return const Stream.empty();
  }

  @override
  Future<E> drain<E>([E? futureValue]) async => futureValue as E;

  @override
  Future<List<int>> elementAt(int index) async => [];

  @override
  Future<bool> every(bool Function(List<int> element) test) async => true;

  @override
  Stream<S> expand<S>(Iterable<S> Function(List<int> element) convert) {
    return const Stream.empty();
  }

  @override
  Future<List<int>> get first async => [];

  @override
  Future<List<int>> firstWhere(
    bool Function(List<int> element) test, {
    List<int> Function()? orElse,
  }) async {
    return orElse?.call() ?? [];
  }

  @override
  Future<S> fold<S>(
    S initialValue,
    S Function(S previous, List<int> element) combine,
  ) async {
    return initialValue;
  }

  @override
  Future<void> forEach(void Function(List<int> element) action) async {}

  @override
  Stream<List<int>> handleError(
    Function onError, {
    bool Function(dynamic error)? test,
  }) {
    return const Stream.empty();
  }

  @override
  bool get isBroadcast => false;

  @override
  Future<bool> get isEmpty async => true;

  @override
  Future<String> join([String separator = '']) async => '';

  @override
  Future<List<int>> get last async => [];

  @override
  Future<List<int>> lastWhere(
    bool Function(List<int> element) test, {
    List<int> Function()? orElse,
  }) async {
    return orElse?.call() ?? [];
  }

  @override
  Future<int> get length async => 0;

  @override
  Stream<S> map<S>(S Function(List<int> event) convert) {
    return const Stream.empty();
  }

  @override
  Future<void> pipe(StreamConsumer<List<int>> streamConsumer) async {
    return streamConsumer.close();
  }

  @override
  Future<List<int>> reduce(
    List<int> Function(List<int> previous, List<int> element) combine,
  ) async {
    return [];
  }

  @override
  Future<List<int>> get single async => [];

  @override
  Future<List<int>> singleWhere(
    bool Function(List<int> element) test, {
    List<int> Function()? orElse,
  }) async {
    return orElse?.call() ?? [];
  }

  @override
  Stream<List<int>> skip(int count) => const Stream.empty();

  @override
  Stream<List<int>> skipWhile(bool Function(List<int> element) test) {
    return const Stream.empty();
  }

  @override
  Stream<List<int>> take(int count) => const Stream.empty();

  @override
  Stream<List<int>> takeWhile(bool Function(List<int> element) test) {
    return const Stream.empty();
  }

  @override
  Stream<List<int>> timeout(
    Duration timeLimit, {
    void Function(EventSink<List<int>> sink)? onTimeout,
  }) {
    return const Stream.empty();
  }

  @override
  Future<List<List<int>>> toList() async => [];

  @override
  Future<Set<List<int>>> toSet() async => {};

  @override
  Stream<S> transform<S>(StreamTransformer<List<int>, S> streamTransformer) {
    return const Stream.empty();
  }

  @override
  Stream<List<int>> where(bool Function(List<int> event) test) {
    return const Stream.empty();
  }
}

class _MockHttpHeaders implements HttpHeaders {
  final Map<String, List<String>> _headers = {};

  @override
  bool chunkedTransferEncoding = false;

  @override
  int contentLength = -1;

  @override
  ContentType? contentType;

  @override
  DateTime? date;

  @override
  DateTime? expires;

  @override
  String? host;

  @override
  DateTime? ifModifiedSince;

  @override
  bool persistentConnection = true;

  @override
  int? port;

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    _headers.putIfAbsent(name.toLowerCase(), () => []).add(value.toString());
  }

  @override
  void clear() => _headers.clear();

  @override
  void forEach(void Function(String name, List<String> values) action) {
    _headers.forEach(action);
  }

  @override
  void noFolding(String name) {}

  @override
  void remove(String name, Object value) {
    _headers[name.toLowerCase()]?.remove(value.toString());
  }

  @override
  void removeAll(String name) {
    _headers.remove(name.toLowerCase());
  }

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    _headers[name.toLowerCase()] = [value.toString()];
  }

  @override
  String? value(String name) {
    return _headers[name.toLowerCase()]?.firstOrNull;
  }

  @override
  List<String>? operator [](String name) => _headers[name.toLowerCase()];
}

// =============================================================================
// Mock Cubits
// =============================================================================

/// Mock ThemeCubit for testing.
class MockThemeCubit extends Mock implements ThemeCubit {}

/// Mock LocalizationCubit for testing.
class MockLocalizationCubit extends Mock implements LocalizationCubit {}

/// Creates a pre-configured MockThemeCubit with default state.
MockThemeCubit createMockThemeCubit({
  ThemeMode initialState = ThemeMode.system,
}) {
  final cubit = MockThemeCubit();
  when(() => cubit.state).thenReturn(initialState);
  when(() => cubit.stream).thenAnswer((_) => Stream.value(initialState));
  when(cubit.close).thenAnswer((_) async {});
  return cubit;
}

/// Creates a pre-configured MockLocalizationCubit with default state.
MockLocalizationCubit createMockLocalizationCubit({
  Locale initialState = const Locale('en'),
}) {
  final cubit = MockLocalizationCubit();
  when(() => cubit.state).thenReturn(initialState);
  when(() => cubit.stream).thenAnswer((_) => Stream.value(initialState));
  when(cubit.close).thenAnswer((_) async {});
  // TODO(agent): why do we mock this instead of using the real repository?
  final dummyLanguages = [
    const LanguageModel(code: 'en', nativeName: 'English', isoCode: 'us'),
    const LanguageModel(code: 'es', nativeName: 'Español', isoCode: 'es'),
    const LanguageModel(code: 'jp', nativeName: '日本語', isoCode: 'jp'),
  ];
  when(() => cubit.displayLanguages).thenReturn(dummyLanguages);
  when(() => cubit.targetLanguages).thenReturn(dummyLanguages);

  return cubit;
}

// =============================================================================
// SharedPreferences Setup
// =============================================================================

/// Sets up SharedPreferences with initial values for testing.
Future<SharedPreferences> setupTestSharedPreferences([
  Map<String, Object> values = const {},
]) async {
  SharedPreferences.setMockInitialValues(values);
  final prefs = await SharedPreferences.getInstance();

  // SharedPreferences caches values in memory. setMockInitialValues only
  // updates the underlying mock storage, not the singleton's local cache if
  // it's already initialized.
  // To ensure tests see the correct values, we manually update the instance.
  await prefs.clear();
  for (final entry in values.entries) {
    if (entry.value is String) {
      await prefs.setString(entry.key, entry.value as String);
    } else if (entry.value is int) {
      await prefs.setInt(entry.key, entry.value as int);
    } else if (entry.value is bool) {
      await prefs.setBool(entry.key, entry.value as bool);
    } else if (entry.value is double) {
      await prefs.setDouble(entry.key, entry.value as double);
    } else if (entry.value is List<String>) {
      await prefs.setStringList(entry.key, entry.value as List<String>);
    }
  }

  return prefs;
}

// =============================================================================
// Test Logging Helpers
// =============================================================================

/// Logs a test action to the console.
void logAction(String message) => debugPrint('[ACTION] $message');

/// Logs a verification step to the console.
void logVerify(String message) => debugPrint('[VERIFY] $message');

/// Logs a numbered test step to the console.
void logStep(int step, String message) => debugPrint('[STEP $step] $message');

/// Logs test setup information.
void logSetup(String message) => debugPrint('[SETUP] $message');

/// Logs test teardown information.
void logTeardown(String message) => debugPrint('[TEARDOWN] $message');

// =============================================================================
// Common Test Setup
// =============================================================================

/// Sets up common test environment (HTTP overrides, etc.).
void setupTestEnvironment() {
  HttpOverrides.global = TestHttpOverrides();
}
