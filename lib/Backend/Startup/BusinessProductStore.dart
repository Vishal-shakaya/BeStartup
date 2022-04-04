import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';

enum ProductType {
  service,
  product,
}

class BusinessProductStore extends GetxController {
  var product_list = [];
  static String? image_url;
  static String? product_type = 'product';
  late ProductType prod_type;

  // Set Product Type :
  SetProductType(type) {
    try {
      if (ProductType.product == type) {
        product_type = 'product';
      }
      if (ProductType.service == type) {
        product_type = 'service';
      }
      print('PRODUCT TYPE ${product_type}');
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // ADD PRODUCT :
  SetProduct({title, description}) {
    var product = {
      'title': title,
      'description': description,
      'type': product_type,
      'image': image_url,
      'timestamp': DateTime.now().toString(),
      'belong_to': '',
      'catigory': '',
    };
    try {
      product_list.add(product);
      image_url = null;
      product_type = null; 

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
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
