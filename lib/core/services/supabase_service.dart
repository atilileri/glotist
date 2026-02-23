import 'package:supabase_flutter/supabase_flutter.dart';

/// Configuration for Supabase integration.
class SupabaseConfig {
  /// Supabase URL.
  static String get supabaseUrl {
    const url = String.fromEnvironment('SUPABASE_URL');
    if (url.isEmpty) {
      throw Exception('SUPABASE_URL not found in environment');
    }
    return url;
  }

  /// Supabase anonymous key.
  static String get supabaseAnonKey {
    const key = String.fromEnvironment('SUPABASE_ANON_KEY');
    if (key.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY not found in environment');
    }
    return key;
  }

  /// Initializes Supabase with provided credentials.
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  /// Returns the Supabase client.
  static SupabaseClient get client => Supabase.instance.client;
}
