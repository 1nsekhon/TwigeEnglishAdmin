import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twige/screens/authenticate/authenticate.dart';
import 'package:twige/screens/home/home.dart';
import 'package:twige/screens/wrapper.dart';
import 'package:twige/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Twige Admin App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        ),
        // home: Wrapper(),
        home: MyHomePage(),
      ),
    );
  }
}
