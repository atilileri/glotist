import 'package:supabase_flutter/supabase_flutter.dart';

/// Configuration for Supabase integration.
class SupabaseConfig {
  // TODO(dev): Replace with ENV configuration
  /// Supabase URL.
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';

  /// Supabase anonymous key.
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

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
