import 'package:flutter/material.dart';
import 'package:twige/styles.dart';

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  bool _showOverlay = false;
  String _displayName = 'No user chosen';
  int _displayNum = 0;
  int _displayIndex = 0;

  //example list of users
  // List<User> users = [
  //   User(username: 'user1', phone: 111000),
  //   User(username: 'user2', phone: 222000),
  //   User(username: 'user3', phone: 333000),
  //   User(username: 'user4', phone: 444000),
  //   User(username: 'user5', phone: 555000),
  // ];

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  void _showDetails(int index) {
    setState(() {
      _displayIndex = index;
      _displayName = users[index].username;
      _displayNum = users[index].phone;
      _toggleOverlay();
    });
  }

  void deleteUser() {
    _toggleOverlay();
    setState(() {
      users.removeAt(_displayIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        centerTitle: false,
        leading: SizedBox(width: 60),
        title: const Text('List of Users',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: whiteColor,
            )),
      ),
      body: Stack(children: [
        // user list
        ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
                hoverColor: tileHoverColor,
                selectedTileColor: tileSelectColor,
                contentPadding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                leading: const Icon(Icons.person),
                title: Text(user.username),
                // selected: _showOverlay,
                onTap: () => _showDetails(index));
          },
        ),
        if (_showOverlay)
          GestureDetector(
            onTap: _toggleOverlay,
            child: Container(
              height: 30,
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('$_displayName, $_displayNum'),
                  GestureDetector(
                      onTap: () => deleteUser(), child: Icon(Icons.delete)),
                ],
              ),
            ),
          ),
      ]),
    );
  }
}

class User {
  String username;
  int phone;

  User({required this.username, required this.phone});

  String name() {
    return username;
  }

  int num() {
    return phone;
  }
}

class UserInfo extends StatelessWidget {
  // User person;
  String name;
  int num;

  UserInfo({required this.name, required this.num});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Center(
    //   child: Text('$name, $num'),
    // ));
    return Container(
        alignment: Alignment.center,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '$name, $num',
          ),
          const Icon(Icons.delete),
        ]));
  }
}
