import 'package:firebase_auth/firebase_auth.dart';


class AuthRepo{
  final FirebaseAuth _firebaseAuth;
  AuthRepo({FirebaseAuth? firebaseAuth}):_firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  Future<User?> loginwithemailpass(String email,String pass)async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      return userCredential.user;
    }
    catch(e){
      throw e;
    }
  } 
  Future<User?> signupwithemailandpass(String email,String pass)async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      
     return userCredential.user!;
      
    }
    catch(e){
      throw e;
    }

  }



    Future<void> signout()async{
    await _firebaseAuth.signOut();
  }
}