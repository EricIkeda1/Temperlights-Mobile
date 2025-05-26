import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static const String _supabaseUrl = '';
  static const String _supabaseAnonKey = '';

  static Future<void> init() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
