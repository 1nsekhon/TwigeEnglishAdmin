

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFile {
  final Reference ref;
  final String name;
  final String url;
  final String english;
  final String  kinyar;
  final String user;

  const FirebaseFile({
    required this.ref,
    required this.name,
    required this.url,
    required this.english,
    required this.kinyar,
    required this.user
  });
}