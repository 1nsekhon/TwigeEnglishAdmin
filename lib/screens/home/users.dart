import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  bool _showOverlay = false;
  String _displayName = 'No user chosen';
  int _displayNum = 0;

  //example list of users
  List<User> users = [
    User(username: 'user1', phone: 111000),
    User(username: 'user2', phone: 222000),
    User(username: 'user3', phone: 333000),
    User(username: 'user4', phone: 444000),
    User(username: 'user5', phone: 555000),
  ];

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  void _showDetails(int index) {
    setState(() {
      _displayName = users[index].username;
      _displayNum = users[index].phone;
      _showOverlay = !_showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users List'),
        ),
        body: Stack(children: [
          // user list
          ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                //return GestureDetector(
                // onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return UserInfo(name: user.username, num: user.phone);
                // }));
                // _toggleOverlay();
                // if(_showOverlay) {
                // GestureDetector(
                //   onTap: _toggleOverlay,
                //   child: UserInfo(name: user.username, num: user.phone),);
                // }
                //},
                //child: ListTile(
                return ListTile(
                    hoverColor: Colors.green,
                    leading: const Icon(Icons.person),
                    title: Text(user.username),
                    onTap: () => _showDetails(index));
              }),
          if (_showOverlay)
            GestureDetector(
                onTap: _toggleOverlay,
                child: Container(
                    color: Colors.black54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('$_displayName, $_displayNum'),
                        Icon(Icons.delete)
                      ],

                      // height: 100,
                      // width: 100,
                      // color: Colors.black54,
                      // child: Center(
                      //     child: Text(
                      //   '$_displayName, $_displayNum',
                      //   style: TextStyle(fontSize: 32.0, color: Colors.white),
                      // )),
                    ))),
        ]));
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
