import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twige/screens/home/uploads.dart';
import 'package:twige/screens/home/users.dart';
import 'package:english_words/english_words.dart';


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

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
        page = UsersPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Row(
              children: [
                Container(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/sheerlove.png')),
                Text(
                  'Welcome Admin!',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                )
              ],
            )),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  // NavigationRailDestination(
                  //     icon: ImageIcon(
                  //       NetworkImage(
                  //           'https://t4.ftcdn.net/jpg/03/16/68/69/360_F_316686992_OvCTP1wfazJhBeMrBBDUGooufSmj2O8G.jpg'),
                  //       color: Colors.white,
                  //     ),
                  // label: Text('')),
                  NavigationRailDestination(
                    icon: Icon(Icons.home_rounded),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.menu_book_rounded),
                    label: Text('Pictionary'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_rounded),
                    label: Text('User Management'),
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
  var numUsers = 25;
  var uploads = 10;
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

  var picRequests = <PicPrev>[];
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData icon;
    // if (appState.favorites.contains(pair)) {
    //   icon = Icons.favorite;
    // } else {
    //   icon = Icons.favorite_border;
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(60, 30, 0, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                child: Text(
                  'Overview:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5,
                ),
              ),
            ])),
        Padding(
          padding: const EdgeInsets.fromLTRB(55, 20, 0, 0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => UserManagement()));
                  },
                  child: UserCard()),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: PictionaryCard(),
              ),
            ],
          ),
        ),
        SizedBox(height: 100),
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     ElevatedButton.icon(
        //       onPressed: () {
        //         appState.toggleFavorite();
        //       },
        //       icon: Icon(icon),
        //       label: Text('Like'),
        //     ),
        //     SizedBox(width: 10),
        //     ElevatedButton(
        //       onPressed: () {
        //         appState.getNext();
        //       },
        //       child: Text('Next'),
        //     ),
        //   ],
        // ),
        Container(
            color: Color.fromARGB(255, 107, 141, 68),
            child: Padding(
              padding: EdgeInsets.all(60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pending Approval...',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      PicPrev(),
                      SizedBox(width: 20),
                      PicPrev(),
                      SizedBox(width: 20),
                      PicPrev(),
                      Text('   PHOTO PREVIEWS...')
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

// class PicsPage extends _MyHomePageState {
// // class PicsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();
//     //var picRequests = filler[];

//     if (appState.favorites.isEmpty) {
//       return Center(
//         child: Text('No favorites yet.'),
//       );
//     }
//     return ListView(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Text('${appState.favorites.length} favorites:'),
//         ),
//         for (var pair in appState.favorites)
//           ListTile(
//             leading: Icon(Icons.favorite),
//             title: Text(pair.asLowerCase),
//           ),
//       ],
//       //Pictionary upload requests
//     );
//   }
// }

class UserManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyHomePageState>();
    var userList = ['example1', 'example2', 'example3'];
    //var picRequests = filler[];

    // if (appState.favorites.isEmpty) {
    //   return Center(
    //     child: Text('No favorites yet.'),
    //   );
    // }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('List of Users'),
        ),
        // for (var i = 0; i < userList.length; i++)
        // listbuilder()
      ],
      //Pictionary upload requests
    );
  }
}

class PicPrev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
      child: Image(
          image: NetworkImage(
              'https://t4.ftcdn.net/jpg/03/16/68/69/360_F_316686992_OvCTP1wfazJhBeMrBBDUGooufSmj2O8G.jpg')),
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

class PictionaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var numRequests = 10;
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
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              height: 85,
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload Requests",
                    style: large,
                  ),
                  SizedBox(height: 15),
                  Row(children: [
                    Container(
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Color.fromARGB(255, 107, 141, 68)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.menu_book_rounded,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        )),
                    SizedBox(width: 40),
                    Text(
                      '$numRequests',
                      style: big,
                    ),
                  ])
                ],
              )),
        ));
  }
}

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var numUsers = 25;
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
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              height: 85,
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active Users",
                    style: large,
                  ),
                  SizedBox(height: 15),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Color.fromARGB(255, 107, 141, 68)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        )),
                    SizedBox(width: 40),
                    Text(
                      '$numUsers',
                      style: big,
                    ),
                  ])
                ],
              )),
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