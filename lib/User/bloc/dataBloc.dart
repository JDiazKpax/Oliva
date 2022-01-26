//Bloc para la traída de datos del usuario

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oliva/User/model/data_event.dart';
import 'package:oliva/User/model/data_state.dart';
import 'package:oliva/User/model/user.dart';
import 'package:oliva/User/repository/cloud_firestore_api.dart';


class DataBloc extends Bloc<DataEvent, DataState> {
  
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  @override
  DataState get initialState => DataUnrequested();
  
 //mapEventToState is where the bloc converts the incoming events 
 //into states the are consumed by the presentational layer.
  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    
    if (event is BringData) {
    //Traer datos del currentUser:
    List<User> dataUser = await _cloudFirestoreAPI.dataUser(); 
    yield DataBrought(dataUser);     
    }

    if (event is UpdateUserData) {
    
    await _cloudFirestoreAPI.updateOnboardSeen(); 
    yield DataUserUpdated();    
    }

    if(event is BuildRecommendedToday){
     List<MyRecommendedToday> recommendedToday = await _cloudFirestoreAPI.buildRecommended();
     yield RecommendedTodayDone(recommendedToday);
    }

    if(event is BuildRecipe){
     List<Recipe> recipe = await _cloudFirestoreAPI.buildRecipe(event.uid);
     yield RecipeDone(recipe);
    }

    if(event is BuildCategory){
     List<Category> category = await _cloudFirestoreAPI.updateRecipesOnCategories(event.category);
     yield CategoryDone(category);
    }

    if(event is BuildObjective){
     List<Category> objective = await _cloudFirestoreAPI.updateRecipesOnObjectives(event.category, event.calories);
     yield CategoryDone(objective);
    }

    if(event is BuildTipToday){
     List<TipToday> tip = await _cloudFirestoreAPI.buildTip();
     yield TipTodayDone(tip);
    }

    if(event is BuildTipList){
     List<Category> tipList = await _cloudFirestoreAPI.buildTipList();
     yield CategoryDone(tipList);
    }

    if(event is BuildTip){
     List<TipToday> tip = await _cloudFirestoreAPI.buildTipSelected(event.uid);
     yield TipDone(tip);
    }

    if(event is BuildTechniqueToday){
     List<TipToday> technique = await _cloudFirestoreAPI.buildTechniqueRandom();
     yield TipTodayDone(technique);
    }

    if(event is BuildTechnique){
     List<TipToday> technique = await _cloudFirestoreAPI.buildTechniqueSelected(event.uid);
     yield TipDone(technique);
    }

    if(event is BuildTechniqueList){
     List<Category> techniqueList = await _cloudFirestoreAPI.buildTechniqueList();
     yield CategoryDone(techniqueList);
    }

    if(event is BuildBlogToday){
     List<TipToday> blog = await _cloudFirestoreAPI.buildBlogRandom();
     yield TipTodayDone(blog);
    }

    if(event is BuildBlog){
     List<TipToday> blog = await _cloudFirestoreAPI.buildBlogSelected(event.uid);
     yield TipDone(blog);
    }

    if(event is BuildBlogList){
     List<Category> blogList = await _cloudFirestoreAPI.buildBlogList();
     yield CategoryDone(blogList);
    }

    if(event is BuildQuickRecipes){
     List<Category> blogList = await _cloudFirestoreAPI.updateRecipesOnQuick(event.category, event.calories);
     yield CategoryDone(blogList);
    }

    if(event is BuildPopularToday){
     List<Category> popularList = await _cloudFirestoreAPI.updateRecipesPopular();
     yield PopularTodayDone(popularList);
    }

    if(event is BuildIngredientsToday){
     List<IngredientToday> ingredientList = await _cloudFirestoreAPI.updateIngredients();
     yield IngredientTodayDone(ingredientList);
    }

    if(event is AddIngredient){
     await _cloudFirestoreAPI.addIngredient(event.ingredient, event.quantity, event.quantityString, event.image);
    }

    if(event is BuildShoppingList){
     List<ShoppingList> shoppingList = await _cloudFirestoreAPI.buildShoppingList();
     yield ShoppingListDone(shoppingList);
    }

    if(event is RemoveIngredient){
     await _cloudFirestoreAPI.removeIngredient(event.ingredient, event.quantity, event.quantityString, event.imgUrl);
    }

    if(event is BuyedIngredient){
     await _cloudFirestoreAPI.buyedIngredient(event.ingredient);
    }

    if(event is UnBuyedIngredient){
     await _cloudFirestoreAPI.unbuyedIngredient(event.ingredient);
    }

    if(event is BuildProfileStats){
     List<ProfileStatsModel> profileStats = await _cloudFirestoreAPI.buildProfileStats();
     yield ProfileStatsDone(profileStats);
    }

    if(event is BuildUploadedRecipes){
     List<Category> uploadedRecipes = await _cloudFirestoreAPI.buildUploadedRecipes();
     yield UploadedRecipesDone(uploadedRecipes);
    }
    
    if(event is BuildInspirationCards){
     List<InspirationModel> inspirationRecipes = await _cloudFirestoreAPI.buildInspiration();
     yield InspirationDone(inspirationRecipes);
    }

    if(event is LikeRecipe){
     await _cloudFirestoreAPI.likeRecipe(event.nameRecipe);
    }

    if(event is BuildFavoriteRecipes){
     List<Category> favoriteRecipes = await _cloudFirestoreAPI.buildFavoriteRecipes();
     yield FavoriteRecipesDone(favoriteRecipes);
    }

    if(event is BuildFavoriteTips){
     List<TipToday> favoriteTips = await _cloudFirestoreAPI.buildFavoriteTips();
     yield FavoriteTipsDone(favoriteTips);
    }

    if(event is LikeTips){
     await _cloudFirestoreAPI.likeTips(event.nameTips);
    }

    if(event is AddRecipe){
     await _cloudFirestoreAPI.addRecipe(event.title, event.category, event.calories, event.portions, event.dificulty, event.hours, event.mins, 
    event.description,event.tips, event.procedure,event.serve, event.quantity, event.quantityText, event.item, event.image);
    }

    if(event is EditThisRecipe){
     await _cloudFirestoreAPI.editThisRecipe(event.title, event.category, event.calories, event.portions, event.dificulty, event.hours, event.mins, 
    event.description,event.tips, event.procedure,event.serve, event.quantity, event.quantityText, event.item, event.image, 
    event.uid, event.imgUrl);
    }

    if(event is BuildSearchResult){
     List<Category> searchResult = await _cloudFirestoreAPI.buildSearchResult(event.textSearch);
     yield SearchResultDone(searchResult);
    }

  } 
}