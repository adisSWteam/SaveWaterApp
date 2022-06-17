import 'package:save_water/authentication/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromAppUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromAppUser(user));
  }

  // SignIn (Email & Pwd)
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong Password!';
      }
    }
  }

  // SignUp (Email & Pwd)
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // return AppUser(uid: user!.uid);
      return _userFromAppUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Password is too weak!';
      } else if (e.code == 'email-already-in-use') {
        return 'This email is already being used.';
      }
    }
    return 'Unknown Error.';
  }

  // SignOut
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      return error.toString();
    }
  }
}
