import 'package:equatable/equatable.dart';

/// Represents a language option in the application.
class LanguageModel extends Equatable {
  /// Creates a [LanguageModel].
  const LanguageModel({
    required this.code,
    required this.nativeName,
    required this.isoCode,
  });

  /// The locale code (e.g., 'en', 'tr', 'jp').
  final String code;

  /// The name of the language in its own language (e.g., 'English', 'Türkçe',
  /// '日本語').
  final String nativeName;

  /// The ISO code used for retrieving the flag icon (e.g., 'us', 'tr', 'jp').
  final String isoCode;

  @override
  List<Object?> get props => [code, nativeName, isoCode];
}
