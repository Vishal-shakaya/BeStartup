import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';

class BusinessVisionStore extends GetxController {
  static var vision;
  // Set Vision
  SetVision({visionText}) async {
    try {
      // NULL CHECK :
      if (visionText == null) {
        return ResponseBack(
            response_type: false, message: 'vision is required');
      }

      vision = visionText;
      return ResponseBack(response_type: true);

      // STORE VALUE IN LOCAL VAR FOR FURTHURE USE :
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

 
 // Return Vision: 
  GetVision() async {
    try {
      return vision;
    } catch (e) {
      return ResponseBack(
        response_type: false,
      );
    }
  }


}
