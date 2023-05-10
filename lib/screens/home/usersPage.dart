// import 'package:flutter/material.dart';
// import 'package:twige/styles.dart';
// import '../../userTile.dart';

// class UsersPage extends StatefulWidget {
//   @override
//   _UsersPageState createState() => _UsersPageState();
// }

// class _UsersPageState extends State<UsersPage> {
//   bool _showOverlay = false;
//   int _displayIndex = 0;
//   String _displayName = 'No user chosen';
//   String _displayNum = "";
//   List<User> users = [];

//   void _toggleOverlay() {
//     setState(() {
//       _showOverlay = !_showOverlay;
//     });
//   }

//   void _showDetails(int index) {
//     setState(() {
//       _displayIndex = index;
//       _displayName = users[_displayIndex].username;
//       _displayNum = users[_displayIndex].phone;
//       _showOverlay = !_showOverlay;
//     });
//   }

//   void _deleteUser() {
//     setState(() {
//       users.removeAt(_displayIndex);
//       _showOverlay = !_showOverlay;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: primaryColor,
//         appBar: AppBar(
//           backgroundColor: secondaryColor,
//           leading: SizedBox(width: 60),
//           centerTitle: false,
//           title: const Text('List of Users'),
//         ),
//         body: Stack(children: [
//           // user list
//           ListView.builder(
//               padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 final user = users[index];

//                 return UserListTile(
//                   username: user.username,
//                   phone: user.phone,
//                   deleteUser: _deleteUser,
//                 );
//               }),
//           if (_showOverlay)
//             GestureDetector(
//                 onTap: _toggleOverlay,
//                 child: ListTile(
//                   key: ValueKey(_displayName),
//                   subtitle: Text('$_displayNum'),
//                 )

//                 // child: Row(
//                 //   mainAxisAlignment: MainAxisAlignment.end,
//                 //   children: [
//                 //     Container(
//                 //         height: double.infinity,
//                 //         width: 600,
//                 //         color: Colors.green,
//                 //         child: Row(
//                 //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 //           children: [
//                 //             Text('$_displayName, $_displayNum'),
//                 //             GestureDetector(
//                 //               onTap: deleteUser,
//                 //               child: Icon(Icons.delete),
//                 //             )
//                 //           ],
//                 //         )),
//                 //   ],
//                 // )
//                 ),
//         ]));
//   }
// }

// class User {
//   String username;
//   int phone;

//   User({required this.username, required this.phone});

//   String name() {
//     return username;
//   }

//   int num() {
//     return phone;
//   }
// }

// class UserInfo extends StatelessWidget {
//   // User person;
//   String name;
//   int num;

//   UserInfo({required this.name, required this.num});

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //     body: Center(
//     //   child: Text('$name, $num'),
//     // ));
//     return Container(
//         alignment: Alignment.center,
//         child:
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           Text(
//             '$name, $num',
//           ),
//           const Icon(Icons.delete),
//         ]));
//   }
// }


// //     return GestureDetector(
// //       onTap: () => _showDetails(index),
// //       child: ListTile(
// //           // key: ValueKey(user.username),
// //           hoverColor: Colors.green,
// //           leading: const Icon(Icons.person),
// //           title: Text(user.username),
// //           subtitle: _showOverlay ? Text('$_displayNum') : null,
// //           onTap: () => _showDetails(index)));

