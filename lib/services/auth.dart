import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prjct_andie/models/user.dart';
import 'package:prjct_andie/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String errorMail = '';
  String errorPass = '';

  //create user obj based on FirebaseUser
  MyUser? _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  String getCurrentUID() {
    return _auth.currentUser!.uid;
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMail = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorPass = 'Wrong password provided.';
      }
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //creat new document id
      await DatabaseService(uid: user!.uid)
          .updateUserData('name', 'bio', 'edu', 'exp', 0, email, user.uid);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPasswordCLIENT(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //creat new document id
      await DatabaseService(uid: user!.uid)
          .updateUserDataClient('name', 0, 'email');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
