import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FileStorage {
  static UploadTask? UploadFileBytes(String destination, Uint8List file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(file);
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
  
  static UploadTask? UploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
}
