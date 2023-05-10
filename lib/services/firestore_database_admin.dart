import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreAdminService {
  String uid = "";
  FirestoreAdminService({required this.uid});

  //collection reference
  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('Admin');

  //first: when admin created
  //second: settings to update data
  Future updateAdminData(String email, String password, bool approved) async {
    return await adminCollection.doc(uid).set({
      'email': email,
      'password': password,
      'approved': 1, //for now, every admin is marked approved
    });
  }
}
