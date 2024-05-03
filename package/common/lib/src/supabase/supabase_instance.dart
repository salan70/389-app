import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_instance.g.dart';

@riverpod
Supabase supabase(SupabaseRef ref) => Supabase.instance;
