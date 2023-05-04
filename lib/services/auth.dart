import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  AdminUser? _userFromCredUser(User? user) {
    return user != null ? AdminUser(uid: user.uid) : null;
  }

  //auth changes user stream
  Stream<AdminUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromCredUser(user));
  }

  //sign in with email + pass
}
