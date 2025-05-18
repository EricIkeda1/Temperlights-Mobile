import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static const String supabaseUrl = ''; //url supabase 
  static const String supabaseAnonKey = "";

  static Future<void> init() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}