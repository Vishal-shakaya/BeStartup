import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Removetartup extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());

/////////////////////////////////////////////////////////////
  /// It takes a id and a model as parameters,
  /// then it queries the database for the document that
  /// matches the startup_id, then it deletes the document
  ///
  /// Args:
  ///   startup_id: The id of the startup that is being deleted.
  ///   model: The name of the collection you want to delete from.
//////////////////////////////////////////////////////////////////
  DeleteDocument({required id, required field_name, required model}) async {
    var doc_id;
    var data;

    var obj_instance = FirebaseFirestore.instance.collection(model);
    var query = obj_instance.where(field_name, isEqualTo: id).get();

    await query.then((value) {
      value.docs.forEach((el) {
        doc_id = el.id;
        obj_instance.doc(doc_id).delete();
        print('Remove $model');
      });
    });
  }

  DeleteFounderWithStartups({required user_id}) async {
    var final_startup_id;
    var data;
    var doc_id;
    // FETCHING DATA FROM FIREBASE
    var store =
        FirebaseFirestore.instance.collection(getBusinessDetailStoreName);
    var query = store.where('founder_id', isEqualTo: user_id).get();

    await query.then((value) {
      data = value.docs.first.data() as Map<String, dynamic>;
    });

    final_startup_id = data['startup_id'];

    try {
      await DeleteDocument(
          field_name: 'startup_id',
          id: final_startup_id,
          model: getBusinessDetailStoreName);

      await DeleteDocument(
          field_name: 'startup_id',
          id: final_startup_id,
          model: getBusinessCatigoryStoreName);

      await DeleteDocument(
          field_name: 'startup_id',
          id: final_startup_id,
          model: getBusinessThumbnailStoreName);

      await DeleteDocument(
          field_name: 'startup_id',
          id: final_startup_id,
          model: getBusinessMilestoneStoreName);

      await DeleteDocument(
          field_name: 'startup_id',
          id: final_startup_id,
          model: getBusinessTeamMemberStoreName);

      await DeleteDocument(
          field_name: 'startup_id',
          id: final_startup_id,
          model: getBusinessProductStoreName);

      await DeleteDocument(
          field_name: 'startup_id',
          id: final_startup_id,
          model: getBusinessVisiontStoreName);

      await DeleteDocument(
          field_name: 'startup_id',
          id: final_startup_id,
          model: getBusinessWhyInvesttStoreName);

      // Delete User Data :
      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessFounderContactStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessFounderDetailStoreName);

      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getLikeStartupStoreName);

      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getSaveStartupStoreName);
      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getStartupStoreName);

      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getStartupPlansStoreName);

      await DeleteDocument(field_name: 'id', id: user_id, model: 'users');

      return ResponseBack(
        response_type: true,
      );
    } catch (e) {
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }
}
