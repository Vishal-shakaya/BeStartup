import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';

class BusinessCatigoryStore extends GetxController {
  // LOCAL STORAGE:
  static var catigories = [];

  // SET CATIGORY :
  SetCatigory({cat}) async {
    try {
      // print(cat);
      catigories.add(cat);
      // print(catigories.length);
      // print('catigories added');
      // print(catigories);
      return await ResponseBack(response_type: true);
    } catch (e) {
      return await ResponseBack(response_type: false);
    }
  }

  // REMOVE CATIGORY AND RETURN RESPONSE
  // IF SUCCESS OR FAIL :
  RemoveCatigory({cat}) async {
    try {
      // print(cat);
        catigories.remove(cat);
      // print('Remove catigory');
      // print(catigories);
      return await ResponseBack(response_type: true);
    } catch (e) {
      return await ResponseBack(response_type: false);
    }
  }

  // GET LIST TO CATIGORY:
  GetCatigories() {
    try {
      // print(catigories);
      return catigories;
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }
}
