import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteQuoteProvider =
    StateNotifierProvider<FavoriteQuoteNotifier, List<String>>(
  (ref) => FavoriteQuoteNotifier(),
);

class FavoriteQuoteNotifier extends StateNotifier<List<String>> {
  FavoriteQuoteNotifier() : super([]);

  void toggleQuoteFavouriteStatus(String quote) {
    if (state.contains(quote)) {
      state = [...state]..remove(quote);
    } else {
      state = [...state, quote];
    }
  }
}
