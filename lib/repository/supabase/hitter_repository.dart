//TODO providerの実装
import 'package:supabase_flutter/supabase_flutter.dart';

class HitterRepository {
  //TODO エラーハンドリング
  //TODO

  Future fetchHitter(Supabase supabase) async {
    final PostgrestResponse response = await supabase.client
        .from('hitter_table')
        .select(
          '*',
          const FetchOptions(
            count: CountOption.exact,
          ),
        )
        .eq('name', '小林誠司')
        .single();

    print('responseee: $response');

    print('response: ${response.count}');
    final test = response.data['id'];

    print('team: $test');

    return response.data['name'];
  }
}
