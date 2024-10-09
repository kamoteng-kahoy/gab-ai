import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: 'https://qjuhnrwimxgvxvcpdtgh.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFqdWhucndpbXhndnh2Y3BkdGdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY0NTExMTAsImV4cCI6MjA0MjAyNzExMH0.NH0sm4ECUZlDOSI_C-8EjBc5A-o6lqHQ6g3DWoARreY',
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}