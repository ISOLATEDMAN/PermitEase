import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo{
  final FirebaseAuth _firebaseAuth;
  AuthRepo({FirebaseAuth? firebaseAuth}):_firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;


  Future<Object?> signInwithEmailAndPassword(String email,String password)async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }
    on FirebaseAuthException catch(e){
      return e;
    }
    catch(e){
      throw e;
    }
  }
  Future<void> signout()async{
    await _firebaseAuth.signOut();
  }


}