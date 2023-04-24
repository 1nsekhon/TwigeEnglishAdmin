import 'package:flutter/material.dart';
import 'package:twige/usersPage.dart';

bool _showSubtitle = false;
bool _showLeadingIcon = true;
bool _showTrailingIcon = false;

class UserTile extends StatefulWidget {
  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  String _username = 'some user!';
  int _phone = 0;

  void _deleteUser(String username) {
    setState(() {
      _username = '';
      _phone = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserListTile(
      username: _username,
      phone: _phone,
      deleteUser: _deleteUser,
    );
  }
}

class UserListTile extends StatefulWidget {
  final String username;
  final int phone;
  final Function deleteUser;

  UserListTile({
    required this.username,
    required this.phone,
    required this.deleteUser,
  });

  @override
  _UserListTileState createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  String _childMessage = 'Hello from child!';

  void deleteUser(username) {
    widget.deleteUser(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showSubtitle = !_showSubtitle;
          _showLeadingIcon = !_showLeadingIcon;
          _showTrailingIcon = !_showTrailingIcon;
        });
      },
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(widget.username),
        subtitle: _showSubtitle ? Text(widget.phone.toString()) : null,
        trailing: _showTrailingIcon
            ? GestureDetector(
                onTap: () => deleteUser(widget.username),
                child: Icon(Icons.delete))
            : null,
        selectedColor: Colors.white,
      ),
    );
    // children: [
    //   Text(widget.parentMessage),
    //   ElevatedButton(
    //     onPressed: _setUserInfo,
    //     child: Text('Update parent message'),
    //   ),
    // ],
  }
}
