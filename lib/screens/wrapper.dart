import 'package:flutter/material.dart';
import 'package:twige/models/user.dart';
import 'package:twige/screens/authenticate/authenticate.dart';
import 'package:twige/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminUser = Provider.of<AdminUser?>(context);
    print(adminUser);

    //return either home or authenticate
    if (adminUser == null) {
      return Authenticate();
    } else {
      return MyHomePage();
    }
  }
}
