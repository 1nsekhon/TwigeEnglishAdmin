import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twige/services/auth.dart';

final databaseReference = FirebaseDatabase.instance.reference();
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return LoginDesktop(toggleView: widget.toggleView);
        },
      ),
    );
  }
}

class LoginDesktop extends StatefulWidget {
  final Function toggleView;
  LoginDesktop({required this.toggleView});

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  bool _isChecked = false;

  final AuthService _auth = AuthService();
  String error = '';
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  //password field state
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child:
                Image.asset('assets/images/sheerlove.png', fit: BoxFit.cover)),
        Expanded(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 21),
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome back',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to your account',
                    style: GoogleFonts.inter(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'abc@example.com',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an Email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '********',
                        labelStyle: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (val) =>
                          val!.length < 6 ? 'Enter Your Password' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _isChecked,
                              onChanged: onChanged,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Remember me',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 25),
                      Text(
                        'Forgot password?',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 0, 84, 152),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signInwithEmailandPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Could not sign-in';
                          });
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                    ),
                    child: Text(
                      'Login now',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  const SizedBox(height: 35),
                  TextButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                    ),
                    child: Text(
                      'New? Register Here',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onChanged(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }

  void saveEmail(String email) {
    databaseReference.child("users").push().set({
      'email': email,
    }).then((value) {
      print("Email saved successfully");
    }).catchError((error) {
      print("Failed to save email: $error");
    });
  }
}
