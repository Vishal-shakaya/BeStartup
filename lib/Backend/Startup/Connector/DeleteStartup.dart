import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
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

///////////////////////////////////////////////////////////////
  /// I'm trying to delete a file from firebase storage and then
  /// delete the document from firestore
  /// Args:
  ///   id: The id of the user
///////////////////////////////////////////////////////////////
  DeleteFounderImage({required id}) async {
    try {
      var data;
      var doc_id;
      var filepath = '';
      var obj_instance = FirebaseFirestore.instance
          .collection(getBusinessFounderDetailStoreName);
      var query = obj_instance.where('user_id', isEqualTo: id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        filepath = data['path'];
      });

      final deleteResp = await DeleteFileFromStorage(filepath);
      print('delete resp $deleteResp');
    } catch (e) {
      print('Error While Delete Founder Image $e');
    }
  }

/////////////////////////////////////////////////////////
  /// I'm trying to delete a file from firebase storage
  ///  and then delete the document from firestore
  /// Args:
  ///   id: The id of the user who uploaded the image
/////////////////////////////////////////////////////////
  DeleteBusinessLogo({required id}) async {
    try {
      var data;
      var doc_id;
      var filepath = '';
      var obj_instance =
          FirebaseFirestore.instance.collection(getBusinessDetailStoreName);
      var query = obj_instance.where('user_id', isEqualTo: id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        filepath = data['path'];
      });

      final deleteResp = await DeleteFileFromStorage(filepath);
      print('delete resp $deleteResp');
    } catch (e) {
      print('Error While Delete logo Image $e');
    }
  }


  DeletePitch({required id}) async {
    try {
      var data;
      var doc_id;
      var filepath = '';
      var obj_instance =
          FirebaseFirestore.instance.collection(getBusinessPitchtStoreName);
      var query = obj_instance.where('user_id', isEqualTo: id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        filepath = data['path'];
      });

      final deleteResp = await DeleteFileFromStorage(filepath);
      print('delete resp $deleteResp');
    } catch (e) {
      print('Error While Delete logo Image $e');
    }
  }

///////////////////////////////////////////////////
  /// It gets the filepath from the database,
  /// then deletes the file from storage
  /// Args:
  ///   id: The id of the user
///////////////////////////////////////////////////
  DeleteThumbnial({required id}) async {
    try {
      var data;
      var doc_id;
      var filepath = '';

      var obj_instance =
          FirebaseFirestore.instance.collection(getBusinessThumbnailStoreName);

      var query = obj_instance.where('user_id', isEqualTo: id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        filepath = data['path'];
      });

      final deleteResp = await DeleteFileFromStorage(filepath);
      print('delete resp $deleteResp');
    } catch (e) {
      print('Error While Delete thumbnail Image $e');
    }
  }

  DeleteProductImage({required id}) async {
    try {
      var data;
      var doc_id;
      var filepath = [];
      var products = [];

      var obj_instance =
          FirebaseFirestore.instance.collection(getBusinessProductStoreName);

      var query = obj_instance.where('user_id', isEqualTo: id).get();

      await query.then((value) {
          data = value.docs.first.data() as Map<String, dynamic>;
          products.add(data['products']);
        });

      products.forEach((element) {
        filepath.add(element['path']);
      });

      for (var i = 0; i < filepath.length; i++) {
        print('deletProduct Image $filepath');
        final deleteResp = await DeleteFileFromStorage(filepath[i]);
        print('delete resp $deleteResp');
      }
    } catch (e) {
      print('Error While Delete product Image $e');
    }
  }

  DeleteTeamMemberImage({required id}) async {
    try {
      var data;
      var doc_id;
      var filepath = [];
      var members = [];

      var obj_instance =
          FirebaseFirestore.instance.collection(getBusinessTeamMemberStoreName);

      var query = obj_instance.where('user_id', isEqualTo: id).get();

      await query.then((value) {
         data = value.docs.first.data() as Map<String, dynamic>;
         members.add(data['members']);

      });

      members.forEach((element) {
        filepath.add(element['path']);
      });

      for (var i = 0; i < filepath.length; i++) {
        print('team memeber Image $filepath');
        final deleteResp = await DeleteFileFromStorage(filepath[i]);
        print('delete resp $deleteResp');
      }
    } catch (e) {
      print('Error While Delete team Image $e');
    }
  }

  DeleteInvestorImage({required id}) async {
    try {
      var data;
      var doc_id;
      var filepath = '';
      var obj_instance =
          FirebaseFirestore.instance.collection(getInvestorUserDetail);
      var query = obj_instance.where('user_id', isEqualTo: id).get();

      await query.then((value) {
        data = value.docs.first.data() as Map<String, dynamic>;
        filepath = data['path'];
      });

      final deleteResp = await DeleteFileFromStorage(filepath);
      print('delete resp $deleteResp');
    } catch (e) {
      print('Error While Delete Founder Image $e');
    }
  }

  DeleteFounderWithStartups({required user_id}) async {
    await DeleteBusinessLogo(id: user_id);
    await DeleteFounderImage(id: user_id);
    await DeleteThumbnial(id: user_id);
    await DeleteProductImage(id: user_id);
    await DeleteTeamMemberImage(id: user_id);
    await DeletePitch(id: user_id);

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
          field_name: 'user_id',
          id: user_id,
          model: getBusinessPitchtStoreName);

      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getLikeStartupStoreName);
      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getSaveStartupStoreName);
      await DeleteDocument(
          field_name: 'user_id', id: user_id, model: getStartupPlansStoreName);
      await DeleteDocument(field_name: 'id', id: user_id, model: 'users');

      return ResponseBack(response_type: true);
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
