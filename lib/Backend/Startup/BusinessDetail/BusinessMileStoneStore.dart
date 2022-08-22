import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class MileStoneStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());

  static Map<String, dynamic> default_tag = {
    'id': uuid.v4(),
    'title': 'same age',
    'description': 'kala',
  };
  var response;

  static RxList milestones = [].obs;

////////////////////////////////////////
  /// ADD MILE STONE :
  /// TRY IF GET ANY ERROR :
  /// RETURN RESPOSNE ACCORDINGLY :
////////////////////////////////////////
  AddMileStone({title, description}) {
    try {
      final Map<String, dynamic> milestone = {
        'id': uuid.v4(),
        'title': title,
        'description': description,
      };

      milestones.add(milestone);

      return ResponseBack(
          response_type: true,
          code: 100,
          message: 'milestone added successfully');
    }

    // return error respnse :
    catch (e) {
      response = {
        'response': false,
        'code': 001,
        'description': 'Error to add milestone',
      };

      return ResponseBack(
          response_type: false, code: 001, message: 'Error to add milestone');
    }
  }

///////////////////////////////////////////////////////
  /// It takes a list of objects, clears the list, removes
  /// the cached data, and then adds the objects to
  /// the list
  ///
  /// Args:
  ///   list: List of Milestone objects
  ///////////////////////////////////////////////////////
  SetMilestoneParam({list}) async {
    milestones.clear();
    await RemoveCachedData(key: getBusinessMilestoneStoreName);
    list.forEach((el) {
      milestones.add(el);
    });
  }

////////////////////////////////////////////////////
  /// It returns the value of the variable milestones.
  ///
  /// Returns:
  ///   the value of the variable milestones.
///////////////////////////////////////////////////////
  GetMilestoneParam() {
    return milestones;
  }

////////////////////////////////////////
// GET PERTICULAR MILESTONE FOR
// DETAIL INFORMATION:
////////////////////////////////////////
  EditMileStone({index, title, description}) {
    try {
      final Map<String, dynamic> milestone = {
        'title': title,
        'description': description,
      };

      milestones[index] = milestone;

      return ResponseBack(
          response_type: true,
          code: 100,
          message: 'Successfully editmilestone');
    }

    // return error respnse :
    catch (e) {
      response = {
        'response': false,
        'code': 001,
        'description': 'Error to edit milestone',
      };

      return ResponseBack(
          response_type: false, code: 001, message: 'Error to edit milestone');
    }
  }

////////////////////////////////////////
// DELETE MILE STONE BY COMPARING
// ID OF ELEMENT :
// RETURN RESPONSE ACCRODINGLY :
////////////////////////////////////////
  DeleteMileStone(id) {
    try {
      milestones.removeWhere((el) => el['id'] == id);
      return response = {
        'response': true,
        'code': 100,
        'description': 'milestone deleteed successfully'
      };
    } catch (e) {
      return response = {
        'response': false,
        'code': 001,
        'description': 'Error milestone deleteed successfully'
      };
    }
  }

////////////////////////////////////////
// RETERIVE LIST OF MILESTONES :
////////////////////////////////////////
  GetMileStonesList() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey(getBusinessMilestoneStoreName);
      if (is_detail) {
        var data = localStore.getString(getBusinessMilestoneStoreName);
        var json_obj = jsonDecode(data!);

        var temp_list = json_obj['milestone'].toList();
        for (int i = 0; i < temp_list.length; i++) {
          milestones.add(temp_list[i]);
        }
        return milestones;
      } else {
        return milestones;
      }
    } catch (e) {
      return milestones;
    }
  }

////////////////////////////////////////
// GET PERTICULAR MILESTONE FOR
// DETAIL INFORMATION:
////////////////////////////////////////

  PersistMileStone() async {
    final localStore = await SharedPreferences.getInstance();
    final startup_id = await startupState.GetStartupId();
    print('milestone startup id ${startup_id}');
    
    try {
      var resp =
          await MileStoneModel(startup_id: startup_id, milestone: milestones);

      localStore.setString(getBusinessMilestoneStoreName, json.encode(resp));

      if (milestones.length < 5) {
        return ResponseBack(
            response_type: false,
            message: 'At leat Define 5 Milestone',
            code: 101);
      }
      // Clear memory allocation : to remove content Dublication:
      milestones.clear();
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
