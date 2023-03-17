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

  static RxList investor_list = [].obs;

  GetProfileImage() async {
    print('Get investor image $investor_image');
    return investor_image;
  }

  SetProfileImage({required image}) {
    investor_image = image;
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
  CreateInvestor({required inv_obj, required user_id}) async {
    final id = uuid.v4();
    try {
      final myStore = store.collection(getStartupInvestorStoreName);
      Map<String, dynamic> investor = {
        'id': id,
        'name': inv_obj['name'] ?? '',
        'position': inv_obj['position'] ?? '',
        'email': inv_obj['email'] ?? '',
        'info': inv_obj['info'] ?? '',
        'image': investor_image ?? temp_logo
      };

      final investor_model = await StartupInvestorModel(
          user_id: user_id, 
          investor: investor, id: id);

      await myStore.add(investor_model);

      investor_list.add(investor);

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

/////////////////////////////////////////////////////
  /// It fetches all the investors that are
  /// associated with a startup
  ///
  /// Args:
  ///   startup_id: The id of the startup you want to
  ///  fetch the investors for.
  ///
  /// Returns:
  ///   A list of investors.
/////////////////////////////////////////////////////
  FetchStartupInvestor({required user_id}) async {
    var data;
    var investors = [];
    try {
      final my_store = store.collection(getStartupInvestorStoreName);
      var query = my_store.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        value.docs.forEach((el) {
          investors.add(el.data()['investor']);
        });
      });

      investor_list.clear();
      investor_list.addAll(investors);

      return ResponseBack(
          response_type: true,
          data: investor_list,
          message: 'Fetch Startup Investors Successfully');
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

//////////////////////////////////////////////////////
  /// It takes an investor id and an investor object, a
  /// and updates the investor in the database.
  ///
  /// Args:
  ///   inv_id: String
  ///   inv_obj: {
  ///
  /// Returns:
  ///   The ResponseBack class is being returned.
//////////////////////////////////////////////////////
  UpdateInvestor({inv_id, inv_obj}) async {
    var data;
    var doc_id;
    print(' Investor id ${inv_id}');
    // print(' Investor object ${inv_obj}');

    try {
      Map<String, dynamic> investor = {
        'id': inv_id,
        'name': inv_obj['name'] ?? '',
        'position': inv_obj['position'] ?? '',
        'email': inv_obj['email'] ?? '',
        'info': inv_obj['info'] ?? '',
        'image': investor_image
      };

      final myStore = store.collection(getStartupInvestorStoreName);
      var query = myStore.where('id', isEqualTo: inv_id).get();

      await query.then((value) {
        data = value.docs.first.data();
        doc_id = value.docs.first.id;
      });

      data['investor'] = investor;
      myStore.doc(doc_id).update(data);

      final index = investor_list.indexWhere((el) => el['id'] == inv_id);
      investor_list[index] = investor;

      return ResponseBack(response_type: true);
    } catch (e) {
      print('error msg ${e}');
      return ResponseBack(response_type: false);
    }
  }

  DeleteInvestor({inv_id}) async {
    var data;
    var doc_id;
    print(' Investor id ${inv_id}');
    // print(' Investor object ${inv_obj}');

    try {
      final myStore = store.collection(getStartupInvestorStoreName);
      var query = myStore.where('id', isEqualTo: inv_id).get();

      await query.then((value) {
        data = value.docs.first.data();
        doc_id = value.docs.first.id;
      });

      myStore.doc(doc_id).delete();

      investor_list.removeWhere((el) {
        return el["id"] == inv_id;
      });

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
