import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BusinessDetailStore extends GetxController {
  static String? image_url;
  static String? business_name;

/////////////////////////////////////
  /// UPLOAD IMAGE IN FIREBASE :
  /// CHECK ERROR OR SUCCESS RESP :
  /// SET BUSINESS LOGO:
////////////////////////////////////////
  SetBusinessLogo({logo, filename}) async {
    try {
      // STORE IMAGE IN FIREBASE :
      // AND GET URL OF IMAGE AFTER UPLOAD IMAGE :
      image_url = await UploadImage(image: logo, filename: filename);

      // RETURN SUCCES RESPONSE WITH IMAGE URL :
      return ResponseBack(response_type: true, data: image_url);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // GET BUSINESS LOGO:
  GetBusinessLogo() {
    return image_url;
  }

////////////////////////////////////////////////////
  // 1. SET BUSINESS NAME :
  // 2. ERROR CHECK :
  // 3. RETURON REPONSE TRUE OF FALSE ACCORDINGLY :
//////////////////////////////////////////////////////
  SetBusinessName(businessName) async {
    try {
      if (businessName==null) {
        return ResponseBack(response_type: false , message: 'Startup name required');
      }
      business_name = businessName;
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  GetBusinessName() {
    return business_name;
  }
}
