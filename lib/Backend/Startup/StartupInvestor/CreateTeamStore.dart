import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';

import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class StartupInvestorStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());
  var businessDetailStore = Get.put(BusinessDetailStore());
  FirebaseFirestore store = FirebaseFirestore.instance;

  static var investor_image;


  GetProfileImage() async {
    print('Get investor image $investor_image');
    return investor_image;
  }

///////////////////////////////////////////////////////////
  /// UploadInvestorProfile() takes an image and a filename,
  ///  uploads the image to Firebase Storage, and
  /// returns the URL of the image
  ///
  /// Args:
  ///   image: The image you want to upload.
  ///   filename: The name of the file to be uploaded.
  ///
  /// Returns:
  ///   A ResponseBack object.
///////////////////////////////////////////////////////////
  UploadInvestorProfile({required image, required filename}) async {
    try {
      // STORE IMAGE IN FIREBASE :
      // AND GET URL OF IMAGE AFTER UPLOAD IMAGE :
      investor_image = await UploadImage(image: image, filename: filename);
      // RETURN SUCCES RESPONSE WITH IMAGE URL :
      return ResponseBack(response_type: true, data: investor_image);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

////////////////////////////////////////////////////////
// CREATE MEMEBER WITH REQUIRED DETAIL :
  /// It takes in an object and a startup_id, creates a
  /// new investor model, and adds it to the database
  ///
  /// Args:
  ///   inv_obj: is a Map object that contains the data
  ///   to be stored in the database.
  ///   startup_id: The id of the startup
  ///
  /// Returns:
  ///   A ResponseBack object.
////////////////////////////////////////////////////////
  CreateInvestor({required inv_obj, required startup_id}) async {
    try {
      final myStore = store.collection(getStartupInvestorStoreName);
      Map<String, dynamic> investor = {
        'id': uuid.v4(),
        'name': inv_obj['name'],
        'position': inv_obj['position'],
        'member_mail': inv_obj['email'],
        'meminfo': inv_obj['info'],
        'image': investor_image,
      };

      final investor_model = await StartupInvestorModel(
          startup_id: startup_id, investor: investor);

      await myStore.add(investor_model);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }
}
