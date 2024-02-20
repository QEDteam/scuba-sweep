import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/utilities/auth_handler.dart';
import 'package:my_flutter_app/utilities/enum.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }

  // Method For Social logins
  Future<AuthResultStatus> signInWithCredential(
      OAuthCredential credential) async {
    AuthResultStatus status;
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        status = AuthResultStatus.successful;
      } else {
        status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleException(e);
    }
    return status;
  }

  // Method for Email & Password Sign In
  Future<AuthResultStatus> signInWithEmailAndPassword(
      String email, String password) async {
    AuthResultStatus status;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        status = AuthResultStatus.successful;
      } else {
        status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleException(e);
    }
    return status;
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
