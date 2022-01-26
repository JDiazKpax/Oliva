//Lógica del SignIn en Firebase con Google, Facebook y Twitter

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;   //crea en _auth una instancia de FirebaseAuth
  final GoogleSignIn googleSignIn = GoogleSignIn();
  
  /*La clase Future se usa para operaciones asíncronas, en este caso la función signIn
  debe retornar un valor FirebaseAuth al terminar. Como la función signIn va a ser asíncrona, 
  se usa "async"*/

  //Autenticación en Firebase con credenciales de Google
  Future<FirebaseUser> signInGoogle() async {               
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();  //cuadro de solicitud de autenticación
    final GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;    //obtiene credenciales

    //ahora autenticamos con Firebase:
    AuthResult authResult = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: gSA.idToken, accessToken: gSA.accessToken));
    FirebaseUser user = authResult.user;
    return user;
  }

  //SignOut de Firebase
  void signOut() async {
    await _auth.signOut().then((onValue) => print("Ended Session"));
    googleSignIn.signOut();
  }

  //SignIn Facebook
  Future<FirebaseUser> signInFacebook(result) async{
    final facebookAuthCred = FacebookAuthProvider.getCredential(accessToken: result);
    AuthResult authResult = await _auth.signInWithCredential(facebookAuthCred);
    FirebaseUser user = authResult.user;
    return user;
    } 

  //SignIn Twitter
  Future<FirebaseUser> signInTwitter(result) async{
    final facebookAuthCred = FacebookAuthProvider.getCredential(accessToken: result);
    AuthResult authResult = await _auth.signInWithCredential(facebookAuthCred);
    FirebaseUser user = authResult.user;
    return user;
    } 
}
