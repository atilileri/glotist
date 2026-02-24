import 'package:equatable/equatable.dart';

/// Represents a language option in the application.
class LanguageModel extends Equatable {
  /// Creates a [LanguageModel].
  const LanguageModel({
    required this.code,
    required this.nativeName,
    required this.isoCode,
    this.isDisplay = false,
    this.isTarget = false,
  });

  /// The locale code (e.g., 'en', 'tr', 'jp').
  final String code;

  /// The name of the language in its own language (e.g., 'English', 'Türkçe',
  /// '日本語').
  final String nativeName;

  /// The ISO code used for retrieving the flag icon (e.g., 'us', 'tr', 'jp').
  final String isoCode;

  /// Whether this language is available for the application interface.
  final bool isDisplay;

  /// Whether this language is available as a target language to learn.
  final bool isTarget;

  @override
  List<Object?> get props => [code, nativeName, isoCode, isDisplay, isTarget];
}
