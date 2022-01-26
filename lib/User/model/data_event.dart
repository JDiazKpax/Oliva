//Es lo que se enviará de UI a Bloc
import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class DataEvent extends Equatable {
 // DataEvent([List props = const []]) : super();
 // get props => [];
 const DataEvent();
}

// will be dispatched when the Flutter application first loads. 
//It will notify bloc that it needs to determine whether or not 
//there is an existing user.
class BringData extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Traer Datos';
}

class UpdateUserData extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Actualizar datos del usuario';
}

class BuildRecommendedToday extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Construir los recomendados del día';
}

class BuildRecipe extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Construir la receta solicitada';
  final String uid;

  BuildRecipe(this.uid);
}

class EditRecipe extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Editar la receta solicitada';
  final String uid;

  EditRecipe(this.uid);
}

class BuildCategory extends DataEvent {
   @override
   List<Object> get props => [];
   final String category;
  
  String toString() => 'Construir las recetas en cada categoría';
  BuildCategory(this.category);
}

class BuildObjective extends DataEvent {
   @override
   List<Object> get props => [];
   final String category;
   final int calories;
  
  String toString() => 'Construir las recetas de acuerdo al objetivo';
  BuildObjective(this.category, this.calories);
}

class BuildTipToday extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Construir el tip random';
}

class BuildTechniqueToday extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Construir una técnica random';
}

class BuildTipList extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Construir el listado de tips';
}

class BuildTip extends DataEvent {
   @override
   List<Object> get props => [];
   final String uid;
  
  String toString() => 'Construir el tip';
  BuildTip(this.uid);
}

class BuildTechnique extends DataEvent {
   @override
   List<Object> get props => [];
   final String uid;
  
  String toString() => 'Construir la técnica';
  BuildTechnique(this.uid);
}

class BuildTechniqueList extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Construir el listado de técnicas';
}

class BuildBlog extends DataEvent {
   @override
   List<Object> get props => [];
   final String uid;
  
  String toString() => 'Construir el Blog';
  BuildBlog(this.uid);
}

class BuildBlogList extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Construir el listado de blogs';
}

class BuildBlogToday extends DataEvent {
   @override
   List<Object> get props => [];
  
  String toString() => 'Construir 4 blogs random';
}

class BuildQuickRecipes extends DataEvent {
   @override
   List<Object> get props => [];
   final String category;
   final int calories;
  
  BuildQuickRecipes(this.category, this.calories);
  String toString() => 'Construye las recetas rápidas';
}

class BuildPopularToday extends DataEvent {
   @override
   List<Object> get props => [];

  String toString() => 'Construye las recetas populares';
}

class BuildIngredientsToday extends DataEvent {
   @override
   List<Object> get props => [];

  String toString() => 'Construye los ingredientes populares';
}

class AddIngredient extends DataEvent {
   @override
   List<Object> get props => [];
   final String ingredient;
   final String quantity;
   final String quantityString;
   final File image; 
   
   AddIngredient(this.ingredient,this.quantity, this.quantityString, this.image);

  String toString() => 'Agrega Ingrediente a la Lista de Compras';
}

class BuildShoppingList extends DataEvent {
   @override
   List<Object> get props => [];

  String toString() => 'Crea la Lista de Compras';
}

class RemoveIngredient extends DataEvent {
   @override
   List<Object> get props => [];
   final String ingredient;
   final String quantity;
   final String quantityString;
   final String imgUrl;
   
   RemoveIngredient(this.ingredient,this.quantity, this.quantityString, this.imgUrl);

  String toString() => 'Borra elemento de la Lista de Compras';
}

class BuyedIngredient extends DataEvent {
   @override
   List<Object> get props => [];
   final String ingredient;
   
   BuyedIngredient(this.ingredient);

  String toString() => 'Borra elemento de la Lista de Compras';
}

class UnBuyedIngredient extends DataEvent {
   @override
   List<Object> get props => [];
   final String ingredient;
   
   UnBuyedIngredient(this.ingredient);

  String toString() => 'Borra elemento de la Lista de Compras';
}

class BuildProfileStats extends DataEvent {
   @override
   List<Object> get props => [];
  String toString() => 'Crea las Estadísticas del Perfíl';
}

class BuildUploadedRecipes extends DataEvent {
   @override
   List<Object> get props => [];
  String toString() => 'Crea el listado de recetas subidas';
}

class BuildFavoriteRecipes extends DataEvent {
   @override
   List<Object> get props => [];
  String toString() => 'Crea el listado de recetas favoritas';
}

class BuildFavoriteTips extends DataEvent {
   @override
   List<Object> get props => [];
  String toString() => 'Crea el listado de tips y técnicas favoritas';
}

class BuildInspirationCards extends DataEvent {
   @override
   List<Object> get props => [];
  String toString() => 'Crea cards aleatorios de recetas para inspirar';
}

class LikeRecipe extends DataEvent {
   @override
   List<Object> get props => [];
   final String nameRecipe;
   LikeRecipe(this.nameRecipe);
    String toString() => 'Aumenta el like y añade a favoritos una receta al presionar el fav icon';
}

class LikeTips extends DataEvent {
   @override
   List<Object> get props => [];
   final String nameTips;
   LikeTips(this.nameTips);
   String toString() => 'Aumenta el like y añade a favoritos un tip al presionar el fav icon';
}

class AddRecipe extends DataEvent {
   @override
   List<Object> get props => [];
    final String title;
    final String category;
    final String calories;
    final String portions;
    final String dificulty;
    final String hours;
    final String mins;
    final String description;
    final List<String> tips;
    final List<String> procedure;
    final List<String> serve;
    final List<String> quantity;
    final List<String> quantityText;
    final List<String> item; 
    final File image;
   
   AddRecipe(this.title, this.category, this.calories, this.portions, this.dificulty, this.hours, this.mins, 
   this.description,this.tips, this.procedure,this.serve, this.quantity, this.quantityText, 
   this.item, this.image); 

  String toString() => 'Agrega Receta Nueva';
}

class EditThisRecipe extends DataEvent {
   @override
   List<Object> get props => [];
    final String title;
    final String category;
    final String calories;
    final String portions;
    final String dificulty;
    final String hours;
    final String mins;
    final String description;
    final List<String> tips;
    final List<String> procedure;
    final List<String> serve;
    final List<String> quantity;
    final List<String> quantityText;
    final List<String> item; 
    final File image;
    final String uid;
    final String imgUrl;
   
   EditThisRecipe(this.title, this.category, this.calories, this.portions, this.dificulty, this.hours, this.mins, 
   this.description,this.tips, this.procedure,this.serve, this.quantity, this.quantityText, 
   this.item, this.image, this.uid, this.imgUrl); 

  String toString() => 'Editar Receta';
}

class BuildSearchResult extends DataEvent {
     @override
    List<Object> get props => [];
    final String textSearch;
    BuildSearchResult(this.textSearch);
    String toString() => 'Trae el resultado de la busqueda';
}
