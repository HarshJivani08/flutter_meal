import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/filters.dart';
import '../models/meal.dart';

class FavouriteNotifier extends StateNotifier<List<Meal>> {
  FavouriteNotifier() : super([]);

  bool toggleFavouriteStatus(Meal meal){
    final mealIsFavourite = state.contains(meal);

    if(mealIsFavourite){
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }else{
      state = [...state,meal];
      return true;
    }
  }
}


final favouriteMealsProvider = StateNotifierProvider<FavouriteNotifier, List<Meal>>((ref) {
    return FavouriteNotifier();
});

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if (activeFilters[Filter.lectoseFree]! && !meal.isLactoseFree){
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan){
      return false;
    }
    return true;
  }).toList();
});