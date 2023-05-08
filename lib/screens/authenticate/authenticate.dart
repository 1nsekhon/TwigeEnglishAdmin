import 'package:flutter/material.dart';
import 'package:twige/screens/authenticate/sign_in.dart';
import 'package:twige/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return MaterialApp(
          title: 'Sign In Page',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: SignIn(toggleView: toggleView) //<--
          );
    } else {
      return MaterialApp(
          title: 'Register Page',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: Reg(toggleView: toggleView) //<--
          );
    }
  }
}
