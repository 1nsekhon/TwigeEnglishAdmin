import 'package:flutter/material.dart';
import 'package:twige/main.dart';
import 'package:twige/styles.dart';

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  bool _showOverlay = false;
  String _displayName = 'No user chosen';
  int _displayNum = 0;
  int _displayPoints = 0;
  int _displayIndex = 0;

  bool _showAdd = false;

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
      _displayPoints = users[index].points;
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

  void toggleAdd() {
    setState(() {
      _showAdd = !_showAdd;
    });
  }

  void submitUser() {
    setState(() {
      _displayName = '';
      _displayNum = 0;
      _displayPoints = 0;
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
                Icons.person_add,
                color: secondaryColor,
              ),
              Text(
                '   Add User',
                style: TextStyle(
                    color: secondaryColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          onPressed: () => toggleAdd(),
        ),
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
            child: Center(
              child: Column(children: [
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
                  height: 110,
                  width: 500,
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(.85),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   'User Information:',
                      //   style: TextStyle(
                      //     color: whiteColor,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 25,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: tileHoverColor, width: 1.5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Username', style: TextThemes.infoHeader),
                            Text('Phone Number', style: TextThemes.infoHeader),
                            Text('Points', style: TextThemes.infoHeader),
                            Container(),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_displayName, style: TextThemes.infoStyle),
                            Text('$_displayNum', style: TextThemes.infoStyle),
                            Text('$_displayPoints',
                                style: TextThemes.infoStyle),
                            GestureDetector(
                              onTap: () => deleteUser(),
                              child: Icon(
                                color: whiteColor,
                                Icons.delete,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        if (_showAdd)
          Center(
            child: Column(children: [
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: whiteColor.withOpacity(.75),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                height: 300,
                width: 400,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () => toggleAdd(),
                          child: Icon(Icons.close_rounded))
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    // style: ButtonStyle(backgroundColor: ),
                    onPressed: () => submitUser(),
                    child: Text(
                      'Add User',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
              )
            ]),
          )
      ]),
    );
  }
}

class User {
  String username;
  int phone;
  int points = 0;

  User({required this.username, required this.phone, points});

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
  int points;

  UserInfo({required this.name, required this.num, this.points = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '$name, $num, $points',
          ),
          const Icon(Icons.delete),
        ]));
  }
}
