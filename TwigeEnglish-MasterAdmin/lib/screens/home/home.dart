import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twige/screens/home/uploads.dart';
import 'package:twige/screens/home/users.dart';
import 'package:english_words/english_words.dart';
import 'package:twige/styles.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 2;

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
        page = UserManagement();
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
                )
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
                      'Uploads',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 30, 0, 0),
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
                      count: uploads.length,
                      icon: Icon(
                        Icons.upload_rounded,
                        color: whiteColor,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: Container(
                  color: secondaryColor,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(60, 30, 60, 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pending Approval...',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            uploads[0],
                            SizedBox(width: 20),
                            uploads[1],
                            SizedBox(width: 20),
                            uploads[2],
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
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