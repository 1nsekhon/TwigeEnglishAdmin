import 'package:flutter/material.dart';
import 'screens/home/uploads.dart';
import 'package:twige/screens/home/users.dart';

const primaryColor = Color.fromARGB(255, 129, 171, 119);
const secondaryColor = Color.fromARGB(255, 72, 105, 64);
const tileHoverColor = Color.fromARGB(255, 160, 210, 148);
const tileSelectColor = Color.fromARGB(255, 62, 82, 57);
const textColor = Color(0xFF3C4046);
const loginBackgroundColor = Color.fromARGB(255, 200, 200, 200);
const borderColor = Color.fromARGB(255, 119, 119, 119);
const whiteColor = Color.fromARGB(255, 255, 255, 255);
const double defaultPadding = 20.0;

List<Upload> uploads = [
  Upload(),
  Upload(),
  Upload(),
  Upload(),
  Upload(),
  Upload()
];

List<User> users = [
  User(username: 'user#1', phone: 111000),
  User(username: 'user2', phone: 222000),
  User(username: 'user3', phone: 333000),
  User(username: 'user4', phone: 444000),
  User(username: 'user5', phone: 555000),
];
