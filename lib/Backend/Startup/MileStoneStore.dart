import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MileStoneStore extends GetxController {
  static Map<String, dynamic> default_tag = {
    'id': UniqueKey(),
    'title': 'same age',
    'description': 'kala',
  };
  var response = {
    'response': true,
    'code': 100,
    'description': 'milestone added successfully'
  };

  List<Map<String, dynamic>> milestones = [default_tag].obs;

  AddMileStone({title, description}) {
    try {
      final Map<String, dynamic> milestone = {
        'id': UniqueKey(),
        'title': title,
        'description': description,
      };

      milestones.add(milestone);
      ChangeNotifier();
      return response;
    }
    // return error respnse :
    catch (e) {
      response = {
        'title': false,
        'code': 001,
        'description': 'Error to add milestone',
      };
      ChangeNotifier();
      return response;
    }
  }

  DeleteMileStone(id) {
    try {
      milestones.removeWhere((el) => el['id']==id);
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

  List<Map<String, dynamic>> GetMileStonesList() {
    return milestones;
  }

  GetMileStone(id) {}
}
