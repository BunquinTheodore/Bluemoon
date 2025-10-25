 import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/foundation.dart';
 
 class AuthProvider extends ChangeNotifier {
   final FirebaseAuth _auth = FirebaseAuth.instance;
 
   User? get user => _auth.currentUser;
 
   bool get isLoggedIn => user != null;
 
   Future<UserCredential> signInAnonymously() async {
     final credential = await _auth.signInAnonymously();
     notifyListeners();
     return credential;
   }
 
   Future<void> signOut() async {
     await _auth.signOut();
     notifyListeners();
   }
 }
