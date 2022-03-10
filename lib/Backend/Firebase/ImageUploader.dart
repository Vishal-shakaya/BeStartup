import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

/////////////////////////////////////////
// PICKED IMAGE AND STORE IN  FILE :
/////////////////////////////////////////
Future UploadImage({Uint8List? image,  String filename=''}) async {
  late UploadTask? upload_process;
  if(filename==''){
    filename = DateTime.now().toString();
   }

  // Validate
  if (image == null) return;
  // UPLOAD FILE LOCAION IN FIREBASE :
  final destination = 'user_profile/profile_image/$filename';
  upload_process = FileStorage.UploadFileBytes(destination, image);

  // ERROR ACCURE
  if (upload_process == null) return;

  final snapshot = await upload_process.whenComplete(() {
    print('PROFILE UPLOADED');
  });

  final urlDownload = await snapshot.ref.getDownloadURL();
  return urlDownload;
}
