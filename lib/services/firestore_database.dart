import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  String uid = "";
  FirestoreService({required this.uid});

  //collection reference
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('Students');

  //first: when user created
  //second: settings to update data
  Future updateStudentData(String name, String phoneNumber, int points) async {
    return await studentCollection.doc(uid).set({
      'points': points,
      'phoneNumber': phoneNumber,
      'name': name,
    });
  }
}
