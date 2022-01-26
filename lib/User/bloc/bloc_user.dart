//me crea una capa superior BLoC, que podrá ser consumida desde todas las clases inferiores.
/*
//import 'dart:io';
//import 'package:basics1/Place/model/place.dart';
//import 'package:basics1/Place/repository/firebase_storage_repository.dart';
//import 'package:basics1/Place/ui/widgets/card_image.dart';
//import 'package:basics1/User/repository/cloud_firestore_api.dart';
//import 'package:basics1/User/repository/cloud_firestore_repository.dart';
//import 'package:basics1/User/ui/widgets/profile_place.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:oliva/User/model/user.dart';
import 'package:oliva/User/repository/auth_respository.dart';
import 'package:oliva/User/repository/cloud_firestore_api.dart';
import 'package:oliva/User/repository/cloud_firestore_repository.dart';
import 'package:oliva/User/ui/screens/onboard_animated.dart';
//import 'package:basics1/User/model/user.dart';

class UserBloc extends Bloc {
  final _authRepository = AuthRepository();

  //Flujo de datos - Streams
  //Stream de Firebase
  //Se define aquí la clase StreamController
  //Si no fuera Firebase sino una BD, el Webservice debería devolver un stream y se debería consumir ese método, no onAuthStateChanged que es de Firebase
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged; //Aquí recibo el stream cuando hay un cambio en el estado de la sesión
  Stream<FirebaseUser> get authStatus => streamFirebase;    //recibo el estado de la sesion y lo devuelvo con el objeto authStatus.
  Future<FirebaseUser> currentUser = FirebaseAuth.instance.currentUser(); //obtener el ID del usuario logueado
  
  //Casos de uso de User:
  //1. Hacer SignIn con Google
  Future<FirebaseUser> signInG() {
    return _authRepository.signInGoogle();
  }
  //1a. Hacer SignIn con Facebook
  Future<FirebaseUser> signInF(result) {
    return _authRepository.signInFacebook(result);
  }
  //1b. Hacer SignIn con Twitter
  Future<FirebaseUser> signInT(result) {
    return _authRepository.signInTwitter(result);
  }


  //2. Hacer SignOut
  signOut (){
    _authRepository.signOut();
  }

  //3. Registrar Usuario en Base de Datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) {
    _cloudFirestoreRepository.updateUserDataFirestore(user);
  }

  //4. Traer datos del usuario
  Stream<QuerySnapshot> dataUserStream(String uid) => Firestore.instance.collection(CloudFirestoreAPI().USERS)
   .where("uid", isEqualTo: uid)
   // .where(field)
    .snapshots();
  List<User> dataUser(List<DocumentSnapshot>dataUserSnapshot) => _cloudFirestoreRepository.dataUser(dataUserSnapshot);

/*
  //4. Subir Place a Firestore
  Future<void> updatePlaceData(Place place) => _cloudFirestoreRepository.updatePlaceData(place);
  
  //5. Subir Foto a Firebase Storage
  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<StorageUploadTask> uploadFile(String path, File image) => _firebaseStorageRepository.uploadFile(path, image);

  //6. Mantenerse escuchando si hay nuevos lugares agregados en Storage
  Stream<QuerySnapshot> placesListStream = Firestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;
  Stream<QuerySnapshot> myPlacesListStream(String uid) => Firestore.instance.collection(CloudFirestoreAPI().PLACES)
    .where("userOwner", isEqualTo: Firestore.instance.document("${CloudFirestoreAPI().USERS}/${uid}"))
    .snapshots();
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);
  List<CardImage> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot);
*/

  @override
  void dispose() {
    
  }

}*/