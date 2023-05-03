import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in with email + pass

  //create user object based on FirebaseUser
  MyUser? _userFromFirebaseUser(MyUser user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }
}
