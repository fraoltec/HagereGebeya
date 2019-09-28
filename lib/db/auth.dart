import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth{
  Future<FirebaseUser> googleSignIn();
}

class Auth implements BaseAuth{
  


  @override
  Future<FirebaseUser> googleSignIn() {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    // final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    return null;
  }
}