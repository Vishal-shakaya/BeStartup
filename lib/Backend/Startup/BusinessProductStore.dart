import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';

class BusinessProductStore extends GetxController {
  var product_list = [];
  static String? image_url; 
  // ADD PRODUCT :
  SetProduct(product) {
    try {
      print(product);
      
      return ResponseBack(response_type: true);
    } catch (e) {}
    return ResponseBack(response_type: false);
  }

  /////////////////////////////////////
  /// UPLOAD IMAGE IN FIREBASE :
  /// CHECK ERROR OR SUCCESS RESP :
  /// SET PRODUCT IMAGE:
////////////////////////////////////////
  UploadProductImage({logo, filename}) async {
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
}
