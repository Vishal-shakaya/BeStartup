import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class InvestorDetailStore extends GetxController {
  static Map<String, dynamic>? investor;
  static String? image_url;
    Map<String, dynamic> clean_resp = {
    'picture': '',
    'name': '',
    'position': '',
    'phone_no': '',
    'primary_mail': '',
    'other_contact': '',
  };
  /////////////////////////////////////
  /// UPLOAD IMAGE IN FIREBASE :
  /// CHECK ERROR OR SUCCESS RESP :
  /// SET PRODUCT IMAGE:
  ////////////////////////////////////////
  UploadFounderImage({image, filename}) async {
    try {
      // STORE IMAGE IN FIREBASE :
      // AND GET URL OF IMAGE AFTER UPLOAD IMAGE :
      image_url = await UploadImage(image: image, filename: filename);

      // RETURN SUCCES RESPONSE WITH IMAGE URL :
      return ResponseBack(response_type: true, data: image_url);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }


  // CRATE investor :
  CreateInvestor(investor) async {
    var localStore = await SharedPreferences.getInstance();
    try {
      try {
        var resp = await InvestorModel(
            user_id: await getUserId,
            email: await getuserEmail,
            name: investor['name'],
            position: investor['position'],
            picture: image_url);

        var resp2 =  await UserContact(
            user_id: await  getUserId,
            email: await getuserEmail,
            primary_mail: investor['email'],
            phone_no: investor['phone_no'],
            other_contact: investor['other_contact']);

        localStore.setString('InvestorUserDetail', json.encode(resp));
        localStore.setString('InvestorUserContact', json.encode(resp2));

        return ResponseBack(response_type: true);
      } catch (e) {
        ResponseBack(response_type: false, message: e);
      }

    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  GetInvestorDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail = localStore.containsKey('InvestorUserDetail');
      bool is_contanct = localStore.containsKey('InvestorUserContact');
      if (is_detail && is_contanct) {
        var detail = localStore.getString('InvestorUserDetail');
        var contact = localStore.getString('InvestorUserContact');

        var detail_obj = jsonDecode(detail!);
        var contact_obj = jsonDecode(contact!);

        Map<String, dynamic> temp_founder = {
          'picture': detail_obj['picture'],
          'name': detail_obj['name'],
          'position': detail_obj['position'],
          'phone_no': contact_obj['phone_no'],
          'primary_mail': contact_obj['primary_mail'],
          'other_contact': contact_obj['other_contact'],
        };
        return temp_founder;
      
      } else {
        return clean_resp;
      }
    } catch (e) {
      return clean_resp;
    }
  }

  
}
