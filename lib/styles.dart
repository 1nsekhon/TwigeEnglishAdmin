import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twige/widgets/upload.dart';
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

List<Upload> accepted = [];

List<User> users = [];

abstract class TextThemes {
  static const TextStyle infoHeader = TextStyle(
    color: whiteColor,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  static const TextStyle infoStyle = TextStyle(
    color: whiteColor,
    fontSize: 20,
  );
}
