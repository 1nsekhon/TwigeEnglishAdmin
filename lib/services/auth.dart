import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  AdminUser? _userFromCredUser(User? user) {
    return user != null ? AdminUser(uid: user.uid) : null; //null if signed out
  }

  //auth changes user stream,
  //returns user object based on user class
  //null if user signed out
  Stream<AdminUser?> get user {
    return _auth.authStateChanges().map(_userFromCredUser);
  }

  //sign in with email + pass

  //sign out
  Future signingOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
