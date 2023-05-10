import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twige/screens/home/uploads.dart';
import 'package:twige/screens/home/users.dart';
import 'package:twige/screens/home/approved.dart';
import 'package:twige/screens/home/usersPage.dart';
import 'package:english_words/english_words.dart';
import 'package:twige/services/auth.dart';
import 'package:twige/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/firebase_file.dart';
import '../../services/database_manager.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final AuthService _auth = AuthService();

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MainPage();
        break;
      case 1:
        page = UploadsPage();
        break;
      case 2:
        page = ApprovedPage();
        break;
      case 3:
        page = UserManagement();
        break;
      case 4:
        page = UsersPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 110,
                  width: 110,
                  child: Image.asset('assets/images/sheerlove.png'),
                ),
                SizedBox(width: 20),
                Text(
                  'Welcome Admin!',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_rounded),
                    label: Text(
                      'Home',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.menu_book_rounded),
                    label: Text(
                      'Pending Uploads',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.thumb_up_alt_sharp),
                    label: Text(
                      'Approved Uploads',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_rounded),
                    label: Text(
                      'User Management',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_rounded),
                    label: Text(
                      'Users II',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late Future<List<FirebaseFile>> futureFiles;
  var files;

  @override

  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAllUnapproved();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();


  @override

    IconData icon;
    // if (appState.favorites.contains(pair)) {
    //   icon = Icons.favorite;
    // } else {
    //   icon = Icons.favorite_border;
    // }

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          backgroundColor: secondaryColor,
          centerTitle: false,
          leading: SizedBox(width: 60),
          title: Text(
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: whiteColor,
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: SizedBox(
        height: 40,
        width: 130,
        child: FloatingActionButton(
          backgroundColor: whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_rounded,
                color: secondaryColor,
              ),
              Text(
                '   Logout',
                style: TextStyle(
                    color: secondaryColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          onPressed: () async {
            await _auth.signingOut();
          },
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
          future:futureFiles,
          builder: (context, snapshot){
            if(snapshot.hasError) {
              return const Center(child: Text('error has occured'));
            } 

            else if(snapshot.hasData) {
               files = snapshot.data!;
                return LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 30, 0, 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Overview:\n',
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     color: whiteColor,
                            //   ),
                            //   textScaleFactor: 1.5,
                            // ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => UserManagement()));
                                  },
                                  child: HomeCard(
                                    cardName: 'Active Users',
                                    count: users.length,
                                    icon: Icon(
                                      Icons.person,
                                      color: whiteColor,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 40),
                                HomeCard(
                                  cardName: 'Uploads',
                                  count: files.length,
                                  icon: Icon(
                                    Icons.upload_rounded,
                                    color: whiteColor,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      /*Container(
                        child: Expanded(
                          child: Container(
                              color: secondaryColor,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(60, 20, 60, 60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Pending Approval...',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        //if (uploads.isEmpty) Text('No pending uploads'),
                                        if (uploads.isNotEmpty)
                                          Container(
                                            height: 150,
                                            width: 150,
                                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                            child: uploads[0],
                                          ),
                                        if (uploads.length >= 2)
                                          Container(
                                            height: 150,
                                            width: 150,
                                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                            child: uploads[1],
                                          ),
                                        if (uploads.length >= 3)
                                          Container(
                                            height: 150,
                                            width: 150,
                                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                            child: uploads[2],
                                          ),
                                      ],
                                    ),
                                    Container(
                                      height: 20,
                                    ),
                                    Text('Accepted Uploads...',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    if (accepted.isNotEmpty)
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          if (accepted.isNotEmpty)
                                            Container(
                                              height: 150,
                                              width: 150,
                                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                              child: accepted[0],
                                            ),
                                          if (accepted.length >= 2)
                                            Container(
                                              height: 150,
                                              width: 150,
                                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                              child: accepted[1],
                                            ),
                                          if (accepted.length >= 3)
                                            Container(
                                              height: 150,
                                              width: 150,
                                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                              child: accepted[2],
                                            ),
                                        ],
                                      ), 
                                  ],
                                ),
                              )),
                        ),
                      ),*/
                    ],
                  );
                });
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ]
      )
    );
  }
}

// class UserCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var numUsers = 20;
//     var theme = Theme.of(context);
//     var large = theme.textTheme.displaySmall!.copyWith(
//       color: theme.colorScheme.surface,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     );
//     var medium = theme.textTheme.displaySmall!.copyWith(
//       color: theme.colorScheme.surface,
//       fontSize: 30,
//     );

//     return Card(
//         color: theme.colorScheme.primary,
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Container(
//             height: 90,
//             width: 200,
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text('Active Users', style: large),
//               ListTile(
//                 leading: Icon(
//                   Icons.person,
//                   color: Colors.white,
//                 ),
//                 title: Text('$numUsers', style: medium),
//               )
//             ]),
//           ),
//         ));
//   }
// }

class HomeCard extends StatefulWidget {
  final String cardName;
  final int count;
  final Icon icon;

  HomeCard({required this.cardName, required this.count, required this.icon});

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var large = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.surface,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    var big = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.surface,
      fontSize: 30,
    );

    return Card(
        color: secondaryColor,
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cardName,
                style: large,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.icon,
                    ),
                  ),
                  Text(
                    widget.count.toString(),
                    style: big,
                  ),
                  SizedBox(width: 15)
                ],
              )
            ],
          ),
        ));
  }
}

// create container then use card
// add margining and padding then columns and rows
// single child scroll
// gesture detector
// if no images, we can add a ternary operator to 
// singlescroll view
// add and commit then git push 'link' branchname