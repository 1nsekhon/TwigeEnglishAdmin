import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twige/styles.dart';
import '../../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool _showOverlay = false;
  String _displayName = 'No user chosen';
  String _displayNum = "";
  int _displayPoints = 0;
  int _displayIndex = 0;
  String phoneNumber = "";
  String name = "";
  String error = "";

  bool _showAdd = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  List<User> users = [];

   void addUser(User user) async{
    print(user.toJson());
    final CollectionReference userRef= db.collection("users");
    await userRef.doc(user.phone).set(user.toJson());
    toggleAdd();
   }


     void getUsers() async{
    
    FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference userRef= db.collection("users");
    await userRef.get().then(
      (querySnapshot) {
        setState(() {
          users.clear();
          users = querySnapshot.docs.map((u) => User.fromSnapshot(u)).toList();
        });
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

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
      _displayNum =  "";
      _displayPoints = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
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
          onPressed: () {
            toggleAdd();
            ChangeNotifierProvider<MyAppState>(
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
            );
          },
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
              child: Form(
            key: _formKey,
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
                        labelText: 'Name',
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter Name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a Phone Number' : null,
                      onChanged: (val) {
                        setState(() => phoneNumber = val);
                      }),
                  SizedBox(height: 40),
                  ElevatedButton(
                    // style: ButtonStyle(backgroundColor: ),
                    onPressed: () {addUser(User(username: name,phone: phoneNumber));},
                    child: Text(
                      'Add User',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  /* Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ), */
                ]),
              )
            ]),
          ))
      ]),
    );
  }
}

class User {
  String username;
  String phone;
  int points = 0;

  User({required this.username, required this.phone, points});

  Map<String, dynamic> toJson() => {
        'name': username,
        'phone': phone,
      };
  
 static User fromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot);
    return User(
        username: snapshot['name'],
        phone: snapshot['phone']);
  }

  String name() {
    return username;
  }

  String num() {
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
