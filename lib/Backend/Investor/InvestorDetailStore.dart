import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';

class InvestorDetailStore extends GetxController {
  static Map<String, dynamic>? investor;

  // CRATE FOUNDER :
  CreateInvestor(investor) async {
    try {
      Map<String, dynamic> temp_founder = {
        'id': investor['id'],
        'user': investor['user'],
        'name': investor['name'],
        'position': investor['position'],
        'phone_no': investor['phone_no'],
        'email': investor['email'],
        'other_contact': investor['other_contact'],
      };
      investor = temp_founder;
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }



  
}
