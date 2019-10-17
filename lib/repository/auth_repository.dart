import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository.intenal();
  factory AuthRepository() => _instance;
  AuthRepository.intenal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleLogin = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount account = await _googleLogin.signIn();
      GoogleSignInAuthentication authentication = await account.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken);
      FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }

  Stream<bool> authStatus() {
    return _firebaseAuth.onAuthStateChanged.map((user) => user != null);
  }

  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  get signOut => _firebaseAuth.signOut;
}
