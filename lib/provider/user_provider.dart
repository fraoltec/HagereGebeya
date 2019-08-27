import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopapp_tut/db/users.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{

  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  FirebaseUser get user => _user;
  UserServices _userServices = UserServices();
  GoogleSignIn _googleSignIn = new GoogleSignIn();

    UserProvider.instance()
      : 
      _auth = FirebaseAuth.instance,   
      _googleSignIn = GoogleSignIn() {

    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  UserProvider.initialize()
    : 
    _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }
   


  Future<bool> signInWithGoogle() async {
    
    try {
      
      // _status = Status.Authenticating;
      
      notifyListeners();
      
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }
  Future<bool> signIn(String email, String password) async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  } 
  
  Future<bool> signUp(String name,String email, String password) async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user){
        Map<String, dynamic> values = {
           "name":name,
          "email":email,
          "userId":user.uid
        };
        _userServices.createUser(values);
      });

      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }
  
  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
  
  Future<void> _onStateChanged(FirebaseUser user) async{
    if(user == null){
      _status = Status.Unauthenticated;
    }else{
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}