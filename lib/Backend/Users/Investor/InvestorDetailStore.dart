import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class InvestorDetailStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());

  static Map<String, dynamic>? investor;

  static String? image_url;
  Map<String, dynamic> clean_resp = {
    'picture': '',
    'name': '',
    'phone_no': '',
    'primary_mail': '',
    'other_contact': '',
  };

  /////////////////////////////////////
  /// UPLOAD IMAGE IN FIREBASE :
  /// CHECK ERROR OR SUCCESS RESP :
  /// SET PRODUCT IMAGE:
  ////////////////////////////////////////
  UploadProfileImage({image, filename}) async {
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
        var investor_detail = await InvestorModel(
            user_id: await userState.GetUserId(),
            email: await userState.GetDefaultMail(),
            name: investor['name'],
            picture: image_url);

        var investor_contact = await UserContact(
            user_id: await userState.GetUserId(),
            email: await userState.GetDefaultMail(),
            primary_mail: investor['email'],
            phone_no: investor['phone_no'],
            other_contact: investor['other_contact']);

        localStore.setString('InvestorUserDetail', json.encode(investor_detail));
        localStore.setString('InvestorUserContact', json.encode(investor_contact));

        print('Investor Detail $investor_detail');
        print('Investor Contact $investor_contact');

        return ResponseBack(response_type: true);
      } catch (e) {
        return ResponseBack(response_type: false, message: create_error_title);
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: create_error_title);
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
          // 'position': detail_obj['position'],
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
