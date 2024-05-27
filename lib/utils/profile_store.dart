import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; 
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createProfile(String name, String phno, String email, bool isAdmin) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
        "name": name,
        "phno": phno,
        "email": email,
        "admin_stat": isAdmin
      });

      // Update display name
      await _auth.currentUser?.updateDisplayName(name);
    } catch (e) {
      throw e; // You might want to handle this differently in a real app
    }
  }
}
