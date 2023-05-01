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
const double englishaultPadding = 20.0;

String exampleSource =
    'https://t4.ftcdn.net/jpg/03/16/68/69/360_F_316686992_OvCTP1wfazJhBeMrBBDUGooufSmj2O8G.jpg';

List<Upload> uploads = [
  Upload(
    english: 'cat',
    kinyar: 'injangwe',
    source: exampleSource,
  ),
  Upload(
    english: 'horse',
    kinyar: 'ifarashi',
    source: exampleSource,
  ),
  Upload(
    english: 'sky',
    kinyar: 'ikirere',
    source: exampleSource,
  ),
  Upload(
    english: 'green',
    kinyar: 'icyatsi',
    source: exampleSource,
  ),
  Upload(
    english: 'hello',
    kinyar: 'muraho',
    source: exampleSource,
  ),
  Upload(
    english: 'fish',
    kinyar: 'amafi',
    source: exampleSource,
  ),
];

List<User> users = [
  User(username: 'user#1', phone: 111000),
  User(username: 'user2', phone: 222000),
  User(username: 'user3', phone: 333000),
  User(username: 'user4', phone: 444000),
  User(username: 'user5', phone: 555000),
];
