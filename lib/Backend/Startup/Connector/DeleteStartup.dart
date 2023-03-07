import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RemoveStartup extends GetxController {
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
    var data;

    // FETCHING DATA FROM FIREBASE
    var store =
        FirebaseFirestore.instance.collection(getBusinessDetailStoreName);
    var query = store.where('user_id', isEqualTo: user_id).get();

    await query.then((value) {
      data = value.docs.first.data() as Map<String, dynamic>;
    });

    try {
      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessDetailStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessCatigoryStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessThumbnailStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessMilestoneStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessTeamMemberStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessProductStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessVisiontStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessWhyInvesttStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessFounderDetailStoreName);

      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getLikeStartupStoreName);
      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getSaveStartupStoreName);
      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getStartupPlansStoreName);

      await DeleteDocument(field_name: 'id', id: user_id, model: 'users');

      return ResponseBack(
        response_type: true,
      );
    } catch (e) {
      print('Error While Delete User with Startup $e');
      return ResponseBack(response_type: false, message: update_error_title);
    }
  }

////////////////////////////////////////////////////////////////////////
  /// DELETE STARTUP AND ITS PLAN :
  /// It deletes all the documents in the firestore database that
  /// have the same startup_id as the
  /// startup_id of the startup that the user wants to delete
  ///
  /// Args:
  ///   final_startup_id: The id of the startup to be deleted
////////////////////////////////////////////////////////////////////////
  DeleteStartup({required user_id}) async {
    try {
      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessDetailStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessCatigoryStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessThumbnailStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessMilestoneStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessTeamMemberStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessProductStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessVisiontStoreName);

      await DeleteDocument(
          field_name: 'user_id',
          id: user_id,
          model: getBusinessWhyInvesttStoreName);
      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getStartupPlansStoreName);

      return ResponseBack(response_type: true);
    } catch (e) {
      print('Error while deleteing startup $e');
      return ResponseBack(response_type: false, message: e);
    }
  }
}
