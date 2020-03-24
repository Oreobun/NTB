/* This controller class allows authentication of a user login through the Firebase database.
It also allows for anonymous log in as well as signing out of a user account.
This class is used in various boundary classes associated with manipulating user information
and allowing access to the application's features.
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sgparking/entity/user.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // Changes the user stream based on the authentication state
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }

  //Method to allow anonymous sign in to the application
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }

  }
  //Method to allow sign in with associated email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Method to allow registration with a valid email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Method that signs a user out of the application
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e){
      print(e.toString());
      return null;
    }
  }

}