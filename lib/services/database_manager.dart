
import 'dart:io';

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
}

