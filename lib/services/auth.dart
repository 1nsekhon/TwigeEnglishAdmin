import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twige/screens/home/home.dart';
import 'package:twige/screens/wrapper.dart';
import 'package:twige/services/firestore_database.dart';
import '../models/user.dart';
import '../styles.dart';

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
  Future signInwithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromCredUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //register w/ phone number and student name
  Future registerPhoneNumber(
      BuildContext context, String phoneNumber, String name) async {
    try {
      UserCredential? result;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          result = await FirebaseAuth.instance.signInWithCredential(credential);
          // ignore: use_build_context_synchronously
          /* Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
          ); */
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          } else {
            print(
                'An error occurred while verifying the phone number: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.pushNamed(context, '/code-verification', arguments: {
            'verificationId': verificationId,
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      if (result != null) {
        User user = result!.user!;
        await FirestoreService(uid: user.uid)
            .updateStudentData(name, phoneNumber, 0);
        return _userFromCredUser(user);
      } else {
        return null;
      }
    } catch (e) {
      print(
          'An error occurred while verifying the phone number: ${e.toString()}');
    }
  }

  //register w/ email & pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromCredUser(user);
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
      print("signing out");
      await _auth.signOut();
      return Wrapper(); //return to Login Page
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //delete student user
  Future deleteUser(String userID) async {
    //have to fetch the user of the right user ID
    //StudentUser user = Stream<AdminUser?>;
    //delete user with that userID
    //await userID.delete();
    print("deleted user");
  }

  //update password
  Future updatePassword(String newPass) async {
    //await user.updatePassword(newPass);
  }
}
