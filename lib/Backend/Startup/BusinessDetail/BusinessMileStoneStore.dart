import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class MileStoneStore extends GetxController {
  static Map<String, dynamic> default_tag = {
    'id': uuid.v4(),
    'title': 'same age',
    'description': 'kala',
  };
  var response;

  RxList milestones = [].obs;

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
      response = {
        'response': true,
        'code': 100,
        'description': 'milestone added successfully'
      };
      return response;
    }
    // return error respnse :
    catch (e) {
      response = {
        'response': false,
        'code': 001,
        'description': 'Error to add milestone',
      };

      return response;
    }
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
      // milestones
      response = {
        'response': true,
        'code': 100,
        'description': 'Successfully editmilestone',
      };
      return response;
    }
    // return error respnse :
    catch (e) {
      response = {
        'response': false,
        'code': 001,
        'description': 'Error to edit milestone',
      };

      return response;
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
    try {
      var resp = await MileStoneModel(
          startup_id: await getStartupId, milestone: milestones);
      localStore.setString(getBusinessMilestoneStoreName, json.encode(resp));
      if (milestones.length < 5) {
        return ResponseBack(
            response_type: false, 
            message: 'At leat Define 5 Milestone'
            ,code:101);
      }
      // Clear memory allocation : to remove content Dublication:
      milestones.clear();
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
