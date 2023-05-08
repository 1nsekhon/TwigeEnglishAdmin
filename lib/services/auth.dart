import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  AdminUser? _userFromCredUser(AdminUser? user) {
    return user != null ? AdminUser(uid: user.uid) : null; //null if signed out
  }

  //auth changes user stream,
  //returns user object based on user class
  //null if user signed out
  Stream<AdminUser?> get user {
    return _auth
        .authStateChanges()
        .map(_userFromCredUser as AdminUser? Function(User?));
  }

  //sign in with email + pass
  Future signInwithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      AdminUser user = result.user as AdminUser;
      return _userFromCredUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //register w/ phone number and Child's name
/*   Future registerWithPhoneNumber(String phoneNumber, String Name) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User user = userCredential.user;
        // If user creation is successful, set user's display name
        /* if (user != null) {
          await user.updateProfile(displayName: name);
        } */
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Failed to verify phone number: ${e.message}');
      },
      codeSent: (String verificationId, int resendToken) async {
        // Prompt user to enter the verification code sent to their phone number
        String smsCode =
            '123456'; // Replace with actual verification code entered by user
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User user = userCredential.user;
        // If user creation is successful, set user's display name
        if (user != null) {
          await user.updateProfile(displayName: name);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval of the verification code timed out
        print('Code auto-retrieval timed out');
      },
      timeout: Duration(seconds: 60),
    );
  } */

  //register w/ email & pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

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
