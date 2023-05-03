
import 'package:universal_io/io.dart';

import 'package:flutter/foundation.dart';
import 'package:twige/models/firebase_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAllApproved() async {
    final ref = FirebaseStorage.instance.ref('approved_photos/');
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

static Future<ListResult> listAllApprovedReferences() async {
    final ref = FirebaseStorage.instance.ref('approved_photos/');
    ListResult result = await ref.listAll();
    return result;
  }

  static Future<List<FirebaseFile>> listAllUnapproved() async {
    final ref = FirebaseStorage.instance.ref('unapproved_photos/');
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future<ListResult> listAllUnapprovedReferences() async {
    final ref = FirebaseStorage.instance.ref('unapproved_photos/');
    ListResult result = await ref.listAll();
    return result;
  }

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
  }

  static Future deleteFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    
    await file.delete();
 }

  static Future uploadFile(Reference ref) async {
    //form local , path to object
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/${ref.name}');

    //where to download in firebase?
    final path = 'approved_photos/${ref.name}';

    final refFinal = FirebaseStorage.instance.ref().child(path);
    refFinal.putFile(file);

  }

   static Future downloadMem(Reference ref) async {
    final storageRef = FirebaseStorage.instance.ref(); //to be extra sure
    final uploadRef = storageRef.child("unapproved_photos/${ref.name}");
    print(uploadRef.fullPath);
    try {
     
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await uploadRef.getData(oneMegabyte);
      if (data == null) {
        throw Exception("Failed to download file");
      }
     
      return data;
      

    } on FirebaseException catch (e) {
     print("Error downloading file: ${e.toString()}");
    // Handle any errors.
     throw e;
      // Handle any errors.
    }

  }

   static Future uploadMem(Reference ref, Uint8List stream) async {
    
    final storageRef = FirebaseStorage.instance.ref();
    final uploadRef = storageRef.child("approved_photos/${ref.name}");

    
    File file = File.fromRawPath(rawPath);

    try {
      // Upload raw data.
      await uploadRef.putFile(file);
    } on FirebaseException catch (e) {
      // ...
    }

  }

  static Future move(Reference ref) async{
    
    //download to mem
    Uint8List stream = await downloadMem(ref);
    //upload from mem to firebase
    await uploadMem(ref, stream);
  }
    
}

