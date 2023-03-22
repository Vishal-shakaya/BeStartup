import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/utils.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

/////////////////////////////////////////////////////////
// PICKED IMAGE AND STORE IN  FILE :
/// It takes an image, uploads it to Firebase Storage,
///  and returns the download URL
/// 
/// Args:
///   image (Uint8List): The image to upload.
///   filename (String): The name of the file to be uploaded.
/// 
/// Returns:
///   A Future&lt;String&gt;
/////////////////////////////////////////////////////////
Future UploadImage({Uint8List? image, String filename = ''}) async {
  late UploadTask? upload_process;
  if (filename == '') {
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



//////////////////////////////////////////////////////////////
/// UploadPitch() is a function that takes a video file and 
/// uploads it to Firebase Storage
/// 
/// Args:
///   video (Uint8List): The video file to be uploaded.
///   filename (String): The name of the file to be uploaded.
/// 
/// Returns:
///   A Future&lt;ResponseBack&gt;
//////////////////////////////////////////////////////////////
Future UploadPitch({Uint8List? video, String filename = ''}) async {
  late UploadTask? upload_process;
  final date = DateTime.now().toString();
  if (filename == '') {
    filename = DateTime.now().toString();
  }

  // Validate
  if (video == null) return;
  // UPLOAD FILE LOCAION IN FIREBASE :
  final destination = 'pitch/$date$filename';
  try {
    upload_process = FileStorage.UploadFileBytes(destination, video);
    // ERROR ACCURE
    if (upload_process == null) return;

    final snapshot = await upload_process.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    final path = await snapshot.ref.fullPath;
    return ResponseBack(
        response_type: true, data: {'url': urlDownload, 'path': path});
  } catch (e) {
    return ResponseBack(response_type: false);
  }
}


/////////////////////////////////////////////////////////////////
/// It takes a path to a file in Firebase Storage and deletes it
/// 
/// Args:
///   path: The path to the file in the Firebase Storage.
/// 
/// Returns:
///   A Future<ResponseBack>
/////////////////////////////////////////////////////////////////
DeleteFileFromStorage(path) async {
  final storageRef = FirebaseStorage.instance.ref();
  try {
    await storageRef.child(path).delete();
    return ResponseBack(response_type: true);
  }
  
   catch (e) {
    print('Error While Delete File $e');
    return ResponseBack(response_type: false);
  }
}
