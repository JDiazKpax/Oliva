import 'package:flutter/material.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final String onboardSeen;

  User({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoURL,
    @required this.onboardSeen,
  });
}

class MyRecommendedToday {
  final String pathImageB;
  final String pathImageL;
  final String pathImageD;
  final String nameB;
  final String nameL;
  final String nameD;
  final bool internet;
  final String uidB;
  final String uidL;
  final String uidD;

  MyRecommendedToday({
    Key key,
    this.pathImageB,
    this.pathImageL,
    this.pathImageD,
    this.nameB,
    this.nameL,
    this.nameD,
    this.internet,
    this.uidB,
    this.uidD,
    this.uidL,
  });
}

class Recipe {
  final int views;
  final String time;
  final List quantity;
  final List quantityString;
  final String owner;
  final String ownerName;
  final String name;
  final int likes;
  final int ingredientsNumber;
  final List ingredients;
  final List ingredientsFull;
  final String imgUrl;
  final String difficulty;
  final String description;
  final String category;
  final int calories;
  final int portions;
  final List tips;
  final List serve;
  final List procedure;
  final String uid;
  final bool internet;

  Recipe({
    Key key,
    this.views,
    this.time,
    this.quantity,
    this.quantityString,
    this.owner,
    this.ownerName,
    this.name,
    this.likes,
    this.ingredientsNumber,
    this.ingredients,
    this.ingredientsFull,
    this.imgUrl,
    this.difficulty,
    this.description,
    this.category,
    this.calories,
    this.portions,
    this.tips,
    this.serve,
    this.procedure,
    this.uid,
    this.internet,
  });
}

class Category {
  final String categoryName;
  final String categoryDescription;
  final Map recipeData;
  final bool internet;

  Category({
    Key key,
    this.categoryName,
    this.categoryDescription,
    this.internet,
    this.recipeData,
  });
}

class TipToday {
  final String pathImage;
  final String title;
  final String text;
  final String imgChef;
  final String owner;
  final String uid;

  TipToday({
    Key key,
    this.pathImage,
    this.title,
    this.text,
    this.imgChef,
    this.owner,
    this.uid,
  });
}

class IngredientToday {
  final String pathImage;
  final String title;

  IngredientToday({
    Key key,
    this.pathImage,
    this.title,
  });
}

 class ShoppingList {
  final List items;
  final List quantity;
  final List quantityText;
  final List imgUrl;
  final List buyedItems;

  ShoppingList({
    Key key,
    this.items,
    this.quantity,
    this.quantityText,
    this.imgUrl,
    this.buyedItems
  });
}

class IngredientFormModel {
  final String item;
  final String quantity;
  final String quantityText;
  IngredientFormModel({
    Key key,
    this.item,
    this.quantity,
    this.quantityText
  });
}

class ProfileStatsModel {
  final String uploadedRecipes;
  final String receivedLikes;
  final String favoriteRecipes;
  final String favoriteTips;
  ProfileStatsModel({
    Key key,
    this.uploadedRecipes,
    this.receivedLikes,
    this.favoriteRecipes,
    this.favoriteTips
  });
}

class InspirationModel {
  final String pathImage;
  final String uid;

  InspirationModel({
    Key key,
    this.pathImage,
    this.uid,
  });
}