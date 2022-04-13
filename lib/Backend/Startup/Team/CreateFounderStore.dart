import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';

class BusinessFounderStore extends GetxController {
  static Map<String, dynamic>? founder;

  // CRATE FOUNDER :
  CreateFounder(founder) async {
    print(founder);
    try {
      Map<String, dynamic> temp_founder = {
        'id': founder['id'],
        'user': founder['user'],
        'name': founder['name'],
        'position': founder['position'],
        'phone_no': founder['phone_no'],
        'email': founder['email'],
        'other_contact': founder['other_contact'],
      };
      founder = temp_founder;
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }



  
}
