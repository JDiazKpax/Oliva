//Es lo que se enviará de Bloc a UI
import 'package:equatable/equatable.dart';
import 'package:oliva/User/model/user.dart';

abstract class DataState extends Equatable {
  @override
  List<Object> get props => [];
}

//Datos no solicitados
class DataUnrequested extends DataState {}

//Datos solicitados
class DataRequested extends DataState {}

//Datos traídos exitosamente
class DataBrought extends DataState {
  final List<User> dataUser;
  DataBrought(this.dataUser);
}

//No se logró traer los datos
class DataUnbrought extends DataState {}

//Datos actualizados
class DataUserUpdated extends DataState {}

//Construir Recomendados del día
class RecommendedTodayDone extends DataState {
  final List<MyRecommendedToday> recommendedToday;
  RecommendedTodayDone(this.recommendedToday);
}

//Construir Receta solicitada
class RecipeDone extends DataState {
  final List<Recipe> recipe;
  RecipeDone(this.recipe);
}

class CategoryDone extends DataState {
  final List<Category> category;
  CategoryDone(this.category);
}

class TipTodayDone extends DataState {
  final List<TipToday> tipToday;
  TipTodayDone(this.tipToday);
}

class TipDone extends DataState {
  final List<TipToday> tip;
  TipDone(this.tip);
} 

class PopularTodayDone extends DataState {
  final List<Category> popularToday;
  PopularTodayDone(this.popularToday);
}

class IngredientTodayDone extends DataState {
  final List<IngredientToday> ingredientToday;
  IngredientTodayDone(this.ingredientToday);
}

class ShoppingListDone extends DataState {
  final List<ShoppingList> shoppingList;
  ShoppingListDone(this.shoppingList);
}

class ProfileStatsDone extends DataState {
  final List<ProfileStatsModel> profileStats;
  ProfileStatsDone(this.profileStats);
}

class UploadedRecipesDone extends DataState {
  final List<Category> uploadedRecipes;
  UploadedRecipesDone(this.uploadedRecipes);
}

class FavoriteRecipesDone extends DataState {
  final List<Category> favoriteRecipes;
  FavoriteRecipesDone(this.favoriteRecipes);
}

class FavoriteTipsDone extends DataState {
  final List<TipToday> favoriteTips;
  FavoriteTipsDone(this.favoriteTips);
}

class InspirationDone extends DataState {
  final List<InspirationModel> inspirationRecipes;
  InspirationDone(this.inspirationRecipes);
}

class SearchResultDone extends DataState {
  final List<Category> searchResult;
  SearchResultDone(this.searchResult);
}