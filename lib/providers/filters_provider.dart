import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutenFree, lectoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lectoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter,bool> chosenFilter){
     state = chosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive;          // not allowed!  => mutable state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);
