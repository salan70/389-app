import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = riverpod.Provider(
  (ref) => Supabase.instance,
);
