import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

enum ProductType {
  service,
  product,
}

class BusinessProductStore extends GetxController {
  var uuid = Uuid();
  // Test Product :
  static Map<String, dynamic?> temp_product = {
    'id': 'some_randodnjflks',
    'title': 'word famous watter battle  cleane',
    'description': long_string,
    'type': 'product',
    'image_url': temp_image,
    'timestamp': DateTime.now().toString(),
    'youtube_link': 'https://www.youtube.com/watch?v=-ImJeamG0As',
    'content_link': 'https://www.youtube.com/watch?v=-ImJeamG0As',
    'belong_to': '',
    'catigory': '',
  };

  RxList product_list = [].obs;
  static String? image_url;
  static String? product_type = 'product';
  static String? youtube_link = '';
  static String? content_link = '';
  late ProductType prod_type;

  // Setting youtube link :
  SetYoutubeLink(link) async {
    try {
      youtube_link = link;
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // Setting product content Link :
  SetContentLink(link) async {
    try {
      content_link = link;
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // Set Product Type :
  SetProductType(type) async {
    try {
      if (ProductType.product == type) {
        product_type = 'product';
      }
      if (ProductType.service == type) {
        product_type = 'service';
      }
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  SetImageUrl(image) async {
    try {
      image_url = image;
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // ADD PRODUCT :
  CreateProduct({title, description}) {
    Map<String, dynamic?> product = {
      'id': uuid.v4(),
      'title': title,
      'description': description,
      'type': product_type,
      'image_url': image_url,
      'timestamp': DateTime.now().toString(),
      'youtube_link': youtube_link,
      'content_link': content_link,
      'belong_to': '',
      'catigory': '',
    };
    try {
      product_list.add(product);
      image_url = null;
      product_type = null;
      youtube_link = null;
      content_link = null;

      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // ADD PRODUCT :
  UpdateProduct({title, description, id, index}) {
    Map<String, dynamic?> product = {
      'id': id,
      'title': title,
      'description': description,
      'type': product_type,
      'image_url': image_url,
      'timestamp': DateTime.now().toString(),
      'youtube_link': youtube_link,
      'content_link': content_link,
      'belong_to': '',
      'catigory': '',
    };
    try {
      product_list[index] = product;
      image_url = null;
      product_type = null;
      youtube_link = null;
      content_link = null;

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

// REMOVE PRODUCT FROM LIST USING ID param:
  RemoveProduct(id) async {
    try {
      product_list.removeWhere((element) => element['id'] == id);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  /// GETTERS

///////////////////////////////////////////////////
  /// GETTING PRODUCT LIST :
  /// 1. CHECK IF PRODUCT IS STORE IN LOCAL STORAGE :
  /// 2. IF STORE THEN UPDATE product_list ;
  /// 3. INSTED OF CREATEING NEW LIST , WE USE UPDATE
  /// METHOD BZ OF product_list has Observer attach :
///////////////////////////////////////////////////
  GetProductList() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      // Check local store for product :
      bool is_detail = localStore.containsKey('BusinessProducts');
      if (is_detail) {
        // Retrive Product  then convert in list then update
        // Product list :
        var data = localStore.getString('BusinessProducts');
        var json_obj = jsonDecode(data!);

        var temp_list = json_obj['products'].toList();
        for (int i = 0; i < temp_list.length; i++) {
          product_list.add(temp_list[i]);
        }
        return product_list;

        // If there is no product then just add temp prodcut to list :
        // and send for example purpose :
      } else {
        product_list.add(temp_product);
        return product_list;
      }

      // To Save widget from crash if error occure then send temp product:
      // print error :
    } catch (e) {
      print('Error While Get Milestones ${e}');
      return false;
    }
  }

  ///////////////////////////////////////////////////////////////
  // STORE PRODUCT LIST LOCALY : PERSIST DATA FOR FURTHUR USAGE:
  // USE LOCAL STORAGE :
  // CREATE PRODUCT MODEL WITH LIST OF PRODUCT IN JSON FORMAT :
  ///////////////////////////////////////////////////////////////
  PersistProduct() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      var resp = await BusinessProductsList(
        user_id: getUserId,
        email: getuserEmail,
        startup_name: getStartupName,
        products: product_list,
      );

      localStore.setString('BusinessProducts', json.encode(resp));
      product_list.clear();
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
