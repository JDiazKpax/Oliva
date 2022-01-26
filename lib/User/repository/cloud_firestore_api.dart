import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oliva/User/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CloudFirestoreAPI {

  final String users = "users";       
  final String profiles = "profiles";
  final String recommended = "recommended";
  final String recipes = "recipes";
  final String categories = "categories";
  final String objectives = "objectives";
  final String tips = "tips";
  final String techniques = "techniques";
  final String blogs = "blogs";
  final String quickRecipes = "quickRecipes";
  final String popularRecipes = "popularRecipes";
  final String ingredients = "ingredients";
  final Firestore _db = Firestore.instance; 

  //Ingresar datos en Firestore
  void insertUserData(User user) async{
    DocumentReference ref = _db.collection(users).document(user.uid); //Creo documento identificado por uid dentro de la colección USERS
    await ref.setData({
      "uid": user.uid,
      "name": user.name,
      "email": user.email,
      "photoUrl": user.photoURL,
      "lastSignIn": DateTime.now(),
    },merge: true);    //para que no sobreescriba lo que ya está
  
    DocumentReference ref2 = _db.collection(profiles).document(user.uid); //Creo documento identificado por uid dentro de la colección USERS
    return await ref2.setData({
      "uid": user.uid,
      "name": user.name,
      "email": user.email,
      "photoUrl": user.photoURL,
    },merge: true);    //para que no sobreescriba lo que ya está
  }

  //Traer datos del usuario actualmente conectado  
    Future<List<User>> dataUser() async{
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot dataUserSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().profiles).where("uid", isEqualTo: currentUser.uid).getDocuments();
    List<User> dataUser = [];
    dataUserSnapshot.documents.forEach((p) {
      dataUser.add(User(
        uid: p.data["uid"], 
        name: p.data["name"], 
        email: p.data["email"], 
        photoURL: p.data["photoUrl"], 
        onboardSeen: p.data["onboardSeen"])
          );
     });
     return dataUser;
     }

  //Actualizar si ya vió el Onboard:
  Future<void> updateOnboardSeen() async{         
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    DocumentReference refUsers = _db.collection(profiles).document(currentUser.uid);
    refUsers.updateData({
            'onboardSeen' : "yes"
          });   
  }

 //Trae los recomendados
  Future<List<MyRecommendedToday>> buildRecommended() async{
    var date = new DateTime.now();
    int day = date.day;
    List<MyRecommendedToday> myRecommendedToday = [];
    QuerySnapshot myRecommendedSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recommended).where("day", isEqualTo: day).getDocuments();
    myRecommendedSnapshot.documents.forEach((p) {
      myRecommendedToday.add(MyRecommendedToday(
        pathImageB: p.data["urlImageB"],
        pathImageL: p.data["urlImageL"],
        pathImageD: p.data["urlImageD"],
        nameB: p.data["nameB"],
        nameL: p.data["nameL"],
        nameD: p.data["nameD"],
        internet: true,
        uidB: p.data["uidB"],
        uidL: p.data["uidL"],
        uidD: p.data["uidD"],
        ));
    });    
    return myRecommendedToday;
  }

  //Trae los datos de la receta
  Future<List<Recipe>> buildRecipe(String uid) async{
    List<Recipe> recipe = [];
    String uidName;
    QuerySnapshot recipeSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recipes).where("uid", isEqualTo: uid).getDocuments();
    recipeSnapshot.documents.forEach((p) {
      uidName = p.data["owner"];
      recipe.add(Recipe(
        views: p.data["views"],
        time: p.data["time"],
        quantity: p.data["quantity"],
        quantityString: p.data["quantityString"],
        owner: p.data["owner"],
        name: p.data["name"],
        likes: p.data["likes"],
        ingredientsNumber: p.data["ingredientsNumber"],
        ingredients: p.data["ingredients"],
        ingredientsFull: p.data["ingredientsFull"],
        imgUrl: p.data["imgUrl"],
        difficulty: p.data["difficulty"],
        description: p.data["description"],
        category: p.data["category"],
        calories: p.data["calories"],
        portions: p.data["portions"],
        tips: p.data["Tips"],
        serve: p.data["Serve"],
        procedure: p.data["Procedure"],
        uid: p.data["uid"],
        internet: true,
        ));
    });

    QuerySnapshot dataUserSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().profiles).where("uid", isEqualTo: uidName).getDocuments();
      dataUserSnapshot.documents.forEach((q) {
        recipe.insert(1, Recipe(ownerName:q.data["name"]));
      });    
    return recipe;
  }

  //crea la tabla de categorías y trae las recetas en una categoría especifica
  Future<List<Category>> updateRecipesOnCategories(String myCategory) async{         
    int n = 0;
    List<Category> bringCategory = [];
    CollectionReference refCategories = _db.collection(categories);
    DocumentReference category = refCategories.document(myCategory);
    QuerySnapshot recipeSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recipes).where("category", isEqualTo: myCategory).getDocuments(); 
    recipeSnapshot.documents.forEach((p) {
      n++;
      category.setData({
        "uid$n" : p.data["uid"],
        "recipeName$n" : p.data["name"],
        "photoUrl$n" : p.data["imgUrl"]
      },merge: true);       
    });

    QuerySnapshot categorySnapshot = await Firestore.instance.collection(CloudFirestoreAPI().categories).where("nameCategory", isEqualTo: myCategory).getDocuments();
    categorySnapshot.documents.forEach((p) {
      bringCategory.add(Category(
        categoryName: p.data["nameCategory"],
        categoryDescription: p.data["description"],        
        internet: true,
        recipeData: p.data,
        ));
    });
    return bringCategory;
  }

  //crea la tabla de objetivos calóricos y trae las recetas de un objetivo específico
  Future<List<Category>> updateRecipesOnObjectives(String myObjective, int calories) async{         
    int n = 0;
    List<Category> bringObjective = [];
    CollectionReference refObjectives = _db.collection(objectives);
    DocumentReference objective = refObjectives.document(myObjective);
    QuerySnapshot objectiveSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recipes).where("calories", isLessThanOrEqualTo: calories).getDocuments(); 
    objectiveSnapshot.documents.forEach((p) {
      n++;
      objective.setData({
        "uid$n" : p.data["uid"],
        "recipeName$n" : p.data["name"],
        "photoUrl$n" : p.data["imgUrl"]
      },merge: true);       
    });

    QuerySnapshot objectiveSnapshot2 = await Firestore.instance.collection(CloudFirestoreAPI().objectives).where("nameObjective", isEqualTo: myObjective).getDocuments();
    objectiveSnapshot2.documents.forEach((p) {
      bringObjective.add(Category(
        categoryName: p.data["nameObjective"],
        categoryDescription: p.data["description"],        
        internet: true,
        recipeData: p.data,
        ));
    });
    return bringObjective;
  }

  //Construye un tip aleatorio
  Future<List<TipToday>> buildTip() async{
    List<TipToday> myTipToday = [];
    QuerySnapshot myTipSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().tips).getDocuments();
    int length = myTipSnapshot.documents.length;
    Random random = new Random();
    int randomNumber = random.nextInt(length);
    myTipToday.add(TipToday(
        pathImage: myTipSnapshot.documents[randomNumber].data["imgUrl"],
        title: myTipSnapshot.documents[randomNumber].data["title"],
        text: myTipSnapshot.documents[randomNumber].data["text"],
        imgChef: myTipSnapshot.documents[randomNumber].data["imgChef"],
        owner: myTipSnapshot.documents[randomNumber].data["owner"],
        uid: myTipSnapshot.documents[randomNumber].data["uid"],
        ));          
    return myTipToday;
  }

  //Construye el Listado de tips
  Future<List<Category>> buildTipList() async{         
    List<Category> bringTips = [];    
    QuerySnapshot tipSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().tips).getDocuments();
    tipSnapshot.documents.forEach((p) {
      bringTips.add(Category(
        categoryName: p.data["title"],
        categoryDescription: p.data["text"],        
        internet: true,
        recipeData: p.data,
        ));
    });
    return bringTips;
  }

  //Construye el tip seleccionado
  Future<List<TipToday>> buildTipSelected(String uid) async{
    List<TipToday> myTipToday = [];
    QuerySnapshot myTipSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().tips).where("uid", isEqualTo: uid).getDocuments();
    myTipToday.add(TipToday(
        pathImage: myTipSnapshot.documents[0].data["imgUrl"],
        title: myTipSnapshot.documents[0].data["title"],
        text: myTipSnapshot.documents[0].data["text"],
        imgChef: myTipSnapshot.documents[0].data["imgChef"],
        owner: myTipSnapshot.documents[0].data["owner"],
        uid: myTipSnapshot.documents[0].data["uid"]
        ));    
    return myTipToday;
  }

  //Construye una técnica aleatoria
  Future<List<TipToday>> buildTechniqueRandom() async{
    List<TipToday> myTipToday = [];
    QuerySnapshot myTipSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().techniques).getDocuments();
    int length = myTipSnapshot.documents.length;
    Random random = new Random();
    int randomNumber = random.nextInt(length);
    myTipToday.add(TipToday(
        pathImage: myTipSnapshot.documents[randomNumber].data["imgUrl"],
        title: myTipSnapshot.documents[randomNumber].data["title"],
        text: myTipSnapshot.documents[randomNumber].data["text"],
        imgChef: myTipSnapshot.documents[randomNumber].data["imgChef"],
        owner: myTipSnapshot.documents[randomNumber].data["owner"],
        uid:myTipSnapshot.documents[randomNumber].data["uid"],
        ));    
    return myTipToday;
  }

  //Construye la técnica seleccionada
  Future<List<TipToday>> buildTechniqueSelected(String uid) async{
    List<TipToday> myTipToday = [];
    QuerySnapshot myTipSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().techniques).where("uid", isEqualTo: uid).getDocuments();
    myTipToday.add(TipToday(
        pathImage: myTipSnapshot.documents[0].data["imgUrl"],
        title: myTipSnapshot.documents[0].data["title"],
        text: myTipSnapshot.documents[0].data["text"],
        imgChef: myTipSnapshot.documents[0].data["imgChef"],
        owner: myTipSnapshot.documents[0].data["owner"],
        uid: myTipSnapshot.documents[0].data["uid"]
        ));    
    return myTipToday;
  }

    //Construye el Listado de técnicas
  Future<List<Category>> buildTechniqueList() async{         
    List<Category> bringTips = [];    
    QuerySnapshot tipSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().techniques).getDocuments();
    tipSnapshot.documents.forEach((p) {
      bringTips.add(Category(
        categoryName: p.data["title"],
        categoryDescription: p.data["text"],        
        internet: true,
        recipeData: p.data,
        ));
    });
    return bringTips;
  }

  //Construye el blog seleccionado
  Future<List<TipToday>> buildBlogSelected(String uid) async{
    List<TipToday> myTipToday = [];
    QuerySnapshot myTipSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().blogs).where("uid", isEqualTo: uid).getDocuments();
    myTipToday.add(TipToday(
        pathImage: myTipSnapshot.documents[0].data["imgUrl"],
        title: myTipSnapshot.documents[0].data["title"],
        text: myTipSnapshot.documents[0].data["text"],
        imgChef: myTipSnapshot.documents[0].data["imgChef"],
        owner: myTipSnapshot.documents[0].data["owner"],
        uid: myTipSnapshot.documents[0].data["uid"]
        ));    
    return myTipToday;
  }

    //Construye el Listado de blogs
  Future<List<Category>> buildBlogList() async{         
    List<Category> bringTips = [];
    QuerySnapshot tipSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().blogs).getDocuments();
    tipSnapshot.documents.forEach((p) {
      bringTips.add(Category(
        categoryName: p.data["title"],
        categoryDescription: p.data["text"],        
        internet: true,
        recipeData: p.data,
        ));
    });
    return bringTips;
  }

  //Construye 4 Blogs aleatorios
  Future<List<TipToday>> buildBlogRandom() async{
    List<TipToday> myBlogToday = [];
    List<int> randomList = new List();
    QuerySnapshot myBlogSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().blogs).getDocuments();
    int length = myBlogSnapshot.documents.length;
    int number;
    bool insert = true;
    Random random = new Random();
    for(int i=0; i<4; i++){
      number = random.nextInt(length);
      while(randomList.contains(number)){
        number = random.nextInt(length);
        if(randomList.length == length){
          insert = false;
          break;
        }
      }

      if(insert == true){
        randomList.add(number);
      }
    }
    randomList.forEach((p) {
      myBlogToday.add(TipToday(
        pathImage: myBlogSnapshot.documents[p].data["imgUrl"],
        title: myBlogSnapshot.documents[p].data["title"],
        text: myBlogSnapshot.documents[p].data["text"],
        imgChef: myBlogSnapshot.documents[p].data["imgChef"],
        owner: myBlogSnapshot.documents[p].data["owner"],
        uid:myBlogSnapshot.documents[p].data["uid"],
        ));
    });
    return myBlogToday;
  }

  //crea la tabla de recetas rápidas y trae las recetas de un tiempo específico
  Future<List<Category>> updateRecipesOnQuick(String myTime, int time) async{         
    int n = 0;
    List<Category> bringRecipes = [];
    CollectionReference refRecipes = _db.collection(quickRecipes);
    DocumentReference recipe = refRecipes.document(myTime);
    QuerySnapshot recipeSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recipes).where("hours", isEqualTo: 0).where("minutes", isLessThanOrEqualTo: time).getDocuments(); 
    recipeSnapshot.documents.forEach((p) {
      n++;
      recipe.setData({
        "uid$n" : p.data["uid"],
        "recipeName$n" : p.data["name"],
        "photoUrl$n" : p.data["imgUrl"]
      },merge: true);       
    });

    QuerySnapshot recipeSnapshot2 = await Firestore.instance.collection(CloudFirestoreAPI().quickRecipes).where("nameObjective", isEqualTo: myTime).getDocuments();
    recipeSnapshot2.documents.forEach((p) {
      bringRecipes.add(Category(
        categoryName: p.data["nameObjective"],
        categoryDescription: p.data["description"],        
        internet: true,
        recipeData: p.data,
        ));
    });
    return bringRecipes;
  }

  //crea la tabla de recetas populares y trae las 10 primeras recetas de acuerdo a los likes
  Future<List<Category>> updateRecipesPopular() async{         
    int n = 0;
    List<Category> bringRecipes = [];
    CollectionReference refRecipes = _db.collection(popularRecipes);
    DocumentReference recipe = refRecipes.document("popular");
    recipe.delete();
    QuerySnapshot popularSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recipes).orderBy("likes",descending: true).limit(10).getDocuments(); 
    popularSnapshot.documents.forEach((p) {
      n++;
      recipe.setData({
        "uid$n" : p.data["uid"],
        "recipeName$n" : p.data["name"],
        "photoUrl$n" : p.data["imgUrl"]
      },merge: true);       
    });

    QuerySnapshot popularSnapshot2 = await Firestore.instance.collection(CloudFirestoreAPI().popularRecipes).getDocuments();
    popularSnapshot2.documents.forEach((p) {
      bringRecipes.add(Category(
        categoryName: "",
        categoryDescription: "",        
        internet: true,
        recipeData: p.data,
        ));
    });
    return bringRecipes;
  }

  //trae 7 ingredientes random
  Future<List<IngredientToday>> updateIngredients() async{         
    List<IngredientToday> ingredientsToday = [];
    List<int> randomList = new List();
    int number;
    bool insert = true;
    QuerySnapshot ingredientsSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().ingredients).getDocuments();
    int length = ingredientsSnapshot.documents.length;
    Random random = new Random();
    for(int i=0; i<7; i++){
      number = random.nextInt(length);
      while(randomList.contains(number)){
        number = random.nextInt(length);
        if(randomList.length == length){
          insert = false;
          break;
        }
      }

      if(insert == true){
        randomList.add(number);
      }
    }
    randomList.forEach((p) {
      ingredientsToday.add(IngredientToday(
        pathImage: ingredientsSnapshot.documents[p].data["imgUrl"],
        title: ingredientsSnapshot.documents[p].data["title"]       
        ));
    });
    return ingredientsToday;
  }

  //Agregar ingrediente a lista de compras:
  Future<void> addIngredient(String ingredient, String quantity, String quantityString, File image) async{         
    String ingredientToUpload;
    var myImgUrl;
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    if(image == null){  
      myImgUrl = "https://firebasestorage.googleapis.com/v0/b/oliva-c5a60.appspot.com/o/unknown.png?alt=media&token=bebf6f88-9911-4228-a17f-d59bd96159c7";
    }else{
       final StorageReference _storageReference = FirebaseStorage.instance.ref().child('ingredientsImg/${currentUser.uid}/${DateTime.now().toString()}.jpg'); //obtengo la url del repositorio
       final StorageUploadTask uploadTask = _storageReference.putFile(image);
       myImgUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    }

    DocumentReference refUsers = _db.collection(profiles).document(currentUser.uid);
    ingredientToUpload = "$ingredient $quantity $quantityString $myImgUrl";  
    refUsers.updateData({
              'toShopItems' : FieldValue.arrayUnion([ingredientToUpload]),
              'imgItems' : FieldValue.arrayUnion([myImgUrl])        
            }); 
  }

  //Crea la Lista de Compras
  Future<List<ShoppingList>> buildShoppingList() async{         
    List<ShoppingList> shoppingList = [];
    List<List<dynamic>> temp1 = [];
    List<String> ingredient = [];
    List<String> quantity = [];
    List<String> quantityText = [];
    List<String> number = [];
    List<String> myImg = [];
    var temp;
    var temp2;
    var temp3;
    var temp4;
    var temp6;
    var temp7;
    List<List<dynamic>> temp5= [];
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot shoppingSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().profiles).where("uid", isEqualTo: currentUser.uid).getDocuments();
    shoppingSnapshot.documents.forEach((p) {      
        temp1.add(p.data["toShopItems"]);
        if(p.data["buyedItems"] != null){
          temp5.add(p.data["buyedItems"]);
        }
    });
    final reg = RegExp(r"[0-9]"".");
    if(temp1[0] != null){    
     for(int i=0; i<temp1[0].length; i++){
      temp = temp1[0][i].split(RegExp(" "r"[0-9]")); //item
      temp2 = temp1[0][i].split(RegExp(r"[0-9]"" ")); //unidades
      temp7 = temp1[0][i].split(" https:");
      temp3 = reg.allMatches(temp7[0]); //cantidad
      temp4 = temp2[1].split(" ");
      ingredient.add(temp[0]);      
      number = [];
      temp3.forEach((match) {
        temp6 = temp1[0][i].substring(match.start, match.end);
        temp6 = temp6.split(" ");
        number.add(temp6[0]); //cantidad
      });
      
      quantity.add(number.join());
      myImg.add(temp4[1]);
      quantityText.add(temp4[0]);
     }   
    }

    shoppingList.add(ShoppingList(
        imgUrl: myImg,
        items: ingredient,
        quantity: quantity,
        quantityText: quantityText,
        buyedItems: temp5,
      ));
    return shoppingList; 
  }

  //Eliminar ingrediente a lista de compras:
  Future<void> removeIngredient(String ingredient, String quantity, String quantityString, String imgUrl) async{         
    String ingredientToDelete;
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    DocumentReference refUsers = _db.collection(profiles).document(currentUser.uid);
    ingredientToDelete = "$ingredient $quantity $quantityString $imgUrl";  
    if(imgUrl != "https://firebasestorage.googleapis.com/v0/b/oliva-c5a60.appspot.com/o/unknown.png?alt=media&token=bebf6f88-9911-4228-a17f-d59bd96159c7")
    {
    refUsers.updateData({
              'toShopItems' : FieldValue.arrayRemove([ingredientToDelete]),
              'buyedItems' : FieldValue.arrayRemove([ingredient]),
              'imgItems' : FieldValue.arrayRemove([imgUrl])
    });
      StorageReference _storageReference = await FirebaseStorage.instance.ref().getStorage().getReferenceFromUrl(imgUrl); //obtengo la url del repositorio
      _storageReference.delete();
     }else{
      refUsers.updateData({
              'toShopItems' : FieldValue.arrayRemove([ingredientToDelete]),
              'buyedItems' : FieldValue.arrayRemove([ingredient]),
    });
    }
  }

  //Marcar ingrediente como comprado en la lista de compras:
  Future<void> buyedIngredient(String ingredient) async{         
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    DocumentReference refUsers = _db.collection(profiles).document(currentUser.uid);
    refUsers.updateData({
              'buyedItems' : FieldValue.arrayUnion([ingredient])          
    }); 
  }

  //Marcar ingrediente como no comprado en la lista de compras:
  Future<void> unbuyedIngredient(String ingredient) async{         
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    DocumentReference refUsers = _db.collection(profiles).document(currentUser.uid);
    refUsers.updateData({
              'buyedItems' : FieldValue.arrayRemove([ingredient])          
    }); 
  }

  //Crea las estadísticas del perfil de usuario
  Future<List<ProfileStatsModel>> buildProfileStats() async{         
    int n = 0;
    int likes = 0;
    int favRecipes = 0;
    int favTips = 0;
    List<ProfileStatsModel> profileStats = [];
    
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot uploadedRecipesSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recipes).where("owner", isEqualTo: currentUser.uid).getDocuments(); 
    uploadedRecipesSnapshot.documents.forEach((p) {
      n++;
      likes = p.data["likes"] + likes;
    });

    QuerySnapshot dataUserSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().profiles).where("uid", isEqualTo: currentUser.uid).getDocuments();
    dataUserSnapshot.documents.forEach((p) {
      if(p.data["favRecipes"] != null){
        favRecipes = p.data["favRecipes"].length;
      }else{
        favRecipes = 0;
      }
      if(p.data["favTips"] != null){ 
        favTips = p.data["favTips"].length;
      }else{
        favTips = 0;
      }

    });

    profileStats.add(ProfileStatsModel(
          uploadedRecipes: n.toString(),
          receivedLikes: likes.toString(),
          favoriteRecipes: favRecipes.toString(),
          favoriteTips: favTips.toString(),
    ));

    return profileStats;
  }

  //Trae las recetas subidas por el usuario
  Future<List<Category>> buildUploadedRecipes() async{         
    List<Category> bringRecipes = [];
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot uploadedRecipesSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recipes).where("owner", isEqualTo: currentUser.uid).getDocuments();
    uploadedRecipesSnapshot.documents.forEach((p) {
      bringRecipes.add(Category(
        categoryName: "",
        categoryDescription: "",        
        internet: true,
        recipeData: p.data,
        ));
    });
    return bringRecipes;
  }

  //Trae las recetas favoritas del usuario
  Future<List<Category>> buildFavoriteRecipes() async{         
    List<Category> bringRecipes = [];
    List<dynamic> recipesList = [];
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot favoriteRecipesSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().profiles).where("uid", isEqualTo: currentUser.uid).getDocuments();
    favoriteRecipesSnapshot.documents.forEach((p) {
        recipesList = p.data["favRecipes"];
    });

    if(recipesList != null){   
      for(int i=0; i<recipesList.length; i++){
        QuerySnapshot favoriteRecipesSnapshot2 = await Firestore.instance.collection(CloudFirestoreAPI().recipes).where("name", isEqualTo: recipesList[i]).getDocuments();
        favoriteRecipesSnapshot2.documents.forEach((p) {
            bringRecipes.add(Category(
              categoryName: "",
              categoryDescription: "",        
              internet: true,
              recipeData: p.data,
              ));
          });
      }
    }

    return bringRecipes;
  }

  //Trae los tips favoritos del usuario
  Future<List<TipToday>> buildFavoriteTips() async{         
    List<TipToday> bringTips = [];
    List<dynamic> tipsList = [];
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot favoriteTipsSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().profiles).where("uid", isEqualTo: currentUser.uid).getDocuments();
    favoriteTipsSnapshot.documents.forEach((p) {
        tipsList = p.data["favTips"];
    });

    if(tipsList != null){
      for(int i=0; i<tipsList.length; i++){
        QuerySnapshot favoriteRecipesSnapshot2 = await Firestore.instance.collection(CloudFirestoreAPI().tips).where("title", isEqualTo: tipsList[i]).getDocuments();
        favoriteRecipesSnapshot2.documents.forEach((p) {
            bringTips.add(TipToday(
              pathImage: p.data["imgUrl"],
              title: p.data["title"],
              text: p.data["text"],
              imgChef: p.data["imgChef"],
              owner: p.data["owner"],
              uid: p.data["uid"]
              ));
          });
      }
    }
    return bringTips;
  }

  //Construye recetas aleatorias que sirven para inspiración
  Future<List<InspirationModel>> buildInspiration() async{
    List<InspirationModel> inspiration = [];
    List<int> randomList = new List();
    QuerySnapshot recipesSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recipes).getDocuments();
    int length = recipesSnapshot.documents.length;
    int number;
    bool insert = true;
    Random random = new Random();
    for(int i=0; i<9; i++){
      number = random.nextInt(length);
      while(randomList.contains(number)){
        number = random.nextInt(length);
        if(randomList.length == length){
          insert = false;
          break;
        }
      }

      if(insert == true){
        randomList.add(number);
      }
    }
    randomList.forEach((p) {
      inspiration.add(InspirationModel(
        pathImage: recipesSnapshot.documents[p].data["imgUrl"],
        uid: recipesSnapshot.documents[p].data["uid"]       
        ));
    });
    return inspiration;
  }

  //Actualizar si le dio like a una receta:
  Future<void> likeRecipe(String recipeName) async{         
    int likes;
    String uid;
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot recipesSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().recipes).where("name", isEqualTo: recipeName).getDocuments();
    likes = recipesSnapshot.documents[0].data["likes"];
    uid = recipesSnapshot.documents[0].data["uid"];
    if(likes != null)
    {
      likes++;
    }else{likes = 1;}
    
    DocumentReference refUsers = _db.collection(recipes).document(uid);
    refUsers.updateData({
         'likes' : likes
    });

    DocumentReference refUsers2 = _db.collection(profiles).document(currentUser.uid);
    refUsers2.updateData({
            'favRecipes' : FieldValue.arrayUnion([recipeName]),
    });   
  }

  //Actualizar si le dio like a un tip:
  Future<void> likeTips(String uid) async{         
    int likes;
    String tipName;
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot recipesSnapshot = await Firestore.instance.collection(CloudFirestoreAPI().tips).where("uid", isEqualTo: uid).getDocuments();
    likes = recipesSnapshot.documents[0].data["likes"];
    tipName = recipesSnapshot.documents[0].data["title"];
     if(likes != null)
    {
      likes++;
    }else{likes = 1;}
    
    DocumentReference refUsers = _db.collection(tips).document(uid);
    refUsers.updateData({
         'likes' : likes
    });

    DocumentReference refUsers2 = _db.collection(profiles).document(currentUser.uid);
    refUsers2.updateData({
            'favTips' : FieldValue.arrayUnion([tipName]),
    });   
  }

  //agregar nueva receta
   Future<void> addRecipe( String title,String category,String calories,String portions, String dificulty,
    String hours,String mins,String description,List<String> tips,List<String> procedure,
    List<String> serve,List<String> quantity,List<String> quantityText,List<String> item,File image) async{         
    
    int itemNumbers = item.length;
    String time = "$hours $mins";
    String uidRecipe;
    var myImgUrl;
    var hoursString = hours.split(RegExp(r"h"));
    var minsString = mins.split(RegExp(r"m"));
    int caloriesInt = int.parse(calories);
    int portionsInt = int.parse(portions);
    int hoursInt = int.parse(hoursString[0]);
    int minsInt = int.parse(minsString[0]);
    List<String> totalItem = new List();
    List<String> rawItems = new List();
    String temp2;
    var temp3;
    for(int i=0; i<quantity.length;i++){
      temp2 = "${item[i]}-${quantity[i]}-${quantityText[i]}";
      temp3 = item[i].split(" ");
      for(int j=0; j<temp3.length;j++){
        if(temp3[j] != "de" || temp3[j] != "De"){
          rawItems.add(temp3[j]);
        }
      }
      totalItem.add(temp2);
    }

    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    
    if(image == null){  
      myImgUrl = "https://firebasestorage.googleapis.com/v0/b/oliva-c5a60.appspot.com/o/unknown.png?alt=media&token=bebf6f88-9911-4228-a17f-d59bd96159c7";
    }else{
       final StorageReference _storageReference = FirebaseStorage.instance.ref().child('recipesImg/${currentUser.uid}/${DateTime.now().toString()}.jpg'); //obtengo la url del repositorio
       final StorageUploadTask uploadTask = _storageReference.putFile(image);
       myImgUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    }
       
    DocumentReference refUsers = _db.collection(recipes).document();
    uidRecipe = refUsers.documentID; 
    refUsers.setData({
              'Procedure' : FieldValue.arrayUnion(procedure), 
              'Serve' : FieldValue.arrayUnion(serve), 
              'Tips' : FieldValue.arrayUnion(tips), 
              'calories' : caloriesInt,
              'portions' : portionsInt,
              'category' : category,
              'description' : description,   
              'difficulty' : dificulty,
              'hours' : hoursInt,
              'imgUrl': myImgUrl, 
              'ingredients': FieldValue.arrayUnion(item),
              'ingredientsFull' : FieldValue.arrayUnion(totalItem),
              'ingredientsRaw' : FieldValue.arrayUnion(rawItems),
              'ingredientsNumber': itemNumbers,
              'likes': 0,
              'minutes': minsInt,
              'name': title,
              'owner': currentUser.uid,
              'time': time,
              'uid': uidRecipe, 
            }); 
  }

  //editar receta
   Future<void> editThisRecipe( String title,String category,String calories,String portions,String dificulty,
    String hours,String mins,String description,List<String> tips,List<String> procedure,
    List<String> serve,List<String> quantity,List<String> quantityText,
    List<String> item,File image, String uid, String imgUrl) async{         
    
    int itemNumbers = item.length;
    String time = "$hours $mins";
    var myImgUrl;
    var hoursString = hours.split(RegExp(r"h"));
    var minsString = mins.split(RegExp(r"m"));
    int caloriesInt = int.parse(calories);
    int portionsInt = int.parse(portions);
    int hoursInt = int.parse(hoursString[0]);
    int minsInt = int.parse(minsString[0]);
    List<String> totalItem = new List();
    List<String> rawItems = new List();
    var temp3;
    String temp2;
    for(int i=0; i<quantity.length;i++){
      temp2 = "${item[i]}-${quantity[i]}-${quantityText[i]}";
      temp3 = item[i].split(" ");
      for(int j=0; j<temp3.length;j++){
        rawItems.add(temp3[j]);
      }
      totalItem.add(temp2);
    }

    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    
    if(image == null){  
      myImgUrl = imgUrl;
    }else{
       final StorageReference _storageReference = FirebaseStorage.instance.ref().child('recipesImg/${currentUser.uid}/${DateTime.now().toString()}.jpg'); //obtengo la url del repositorio
       final StorageUploadTask uploadTask = _storageReference.putFile(image);
       myImgUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    }
       
    DocumentReference refUsers = _db.collection(recipes).document(uid);
    refUsers.updateData({
              'Procedure' : FieldValue.delete(), 
              'Serve' : FieldValue.delete(), 
              'Tips' : FieldValue.delete(), 
              'ingredients': FieldValue.delete(),
              'ingredientsFull' : FieldValue.delete(),
              'ingredientsRaw' : FieldValue.delete(),
            }); 
    
    refUsers.updateData({
              'Procedure' : FieldValue.arrayUnion(procedure), 
              'Serve' : FieldValue.arrayUnion(serve), 
              'Tips' : FieldValue.arrayUnion(tips), 
              'calories' : caloriesInt,
              'portions' : portionsInt,
              'category' : category,
              'description' : description,   
              'difficulty' : dificulty,
              'hours' : hoursInt,
              'imgUrl': myImgUrl, 
              'ingredients': FieldValue.arrayUnion(item),
              'ingredientsFull' : FieldValue.arrayUnion(totalItem),
              'ingredientsRaw' : FieldValue.arrayUnion(rawItems),
              'ingredientsNumber': itemNumbers,
              'minutes': minsInt,
              'name': title,
              'time': time,
            }); 
  }

  //Busqueda de ingrediente
  Future<List<Category>> buildSearchResult(String searchText) async{         
    List<Category> bringRecipes = [];
    List<dynamic> options =[];
    List<String> temp = searchText.split("");
    temp[0] = temp[0].toUpperCase();
    String newText = temp.join();  //La primera mayúscula

    options.add(searchText);
    options.add(searchText.toUpperCase());
    options.add(searchText.toLowerCase());
    options.add(searchText + "s");
    options.add(searchText.substring(0,(searchText.length-1)));
    options.add(newText);
    options.add(newText.substring(0,(newText.length-1)));
    options.add(newText + "s");

    QuerySnapshot searchResultSnapshot = await 
      Firestore.instance
      .collection(CloudFirestoreAPI().recipes)
      .where("ingredientsRaw", arrayContainsAny: options)
      .getDocuments();
    searchResultSnapshot.documents.forEach((p) {
      bringRecipes.add(Category(
        categoryName: "",
        categoryDescription: "",        
        internet: true,
        recipeData: p.data,
        ));
    });
    return bringRecipes;
  }
}