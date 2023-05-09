import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twige/models/user.dart';
import 'package:twige/screens/home/home.dart';
import 'package:twige/screens/wrapper.dart';
import 'package:twige/services/auth.dart';
import 'package:twige/styles.dart';
import 'firebase_options.dart';
import 'package:universal_io/io.dart';

Future<void> main() async {
  final httpClient = HttpClient();
  final request = await httpClient.getUrl(Uri.parse("http://google.com"));
  final response = await request.close();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AdminUser?>.value(
        catchError: (_, __) => null,
        value: AuthService().user,
        initialData: null,
        builder: (context, child) => ChangeNotifierProvider<MyAppState>(
              create: (context) => MyAppState(),
              child: MaterialApp(
                title: 'Twige Admin App',
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
                ),
                //home: Wrapper(),
                home: MyHomePage(),
              ),
            ));
  }
}
