import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MileStoneStore extends GetxController {
  static Map<String, dynamic> default_tag = {
    'id': UniqueKey(),
    'title': 'same age',
    'description': 'kala',
  };
  var response;

  List<Map<String, dynamic>> milestones = [default_tag].obs;

////////////////////////////////////////
  /// ADD MILE STONE :
  /// TRY IF GET ANY ERROR :
  /// RETURN RESPOSNE ACCORDINGLY :
////////////////////////////////////////
  AddMileStone({title, description}) {
    try {
      final Map<String, dynamic> milestone = {
        'id': UniqueKey(),
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
      print(milestone[index]);
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
  List<Map<String, dynamic>> GetMileStonesList() {
    return milestones;
  }

////////////////////////////////////////
// GET PERTICULAR MILESTONE FOR
// DETAIL INFORMATION:
////////////////////////////////////////
  GetMileStone(id) {}
}
