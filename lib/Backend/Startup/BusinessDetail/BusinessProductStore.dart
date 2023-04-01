import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
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
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());
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

  static RxList product_list = [].obs;
  static String? image_url;
  static String? path;
  static String? product_type = 'product';
  static String? youtube_link = '';
  static String? content_link = '';
  late ProductType prod_type;
  static var deleteProductpath = [];

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

  SetProductList({list}) async {
    product_list.clear();
    RemoveCachedData(key: getBusinessProductStoreName);
    list.forEach((el) {
      product_list.add(el);
    });
    return product_list;
  }

  GetProducts() async {
    return product_list;
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
      'path': path,
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
  UpdateProduct({title, description, id, index}) async {
    final localStore = await SharedPreferences.getInstance();
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
      'path': path
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
      final resp = await UploadImage(image: logo, filename: filename);

      if (resp['response']) {
        image_url = resp['data']['url'];
        path = resp['data']['path'];
      }
      if (!resp['response']) {
      }

      // RETURN SUCCES RESPONSE WITH IMAGE URL :
      return ResponseBack(response_type: true, data: image_url);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  GetDeleteProductPath() {
    return deleteProductpath;
  }

// REMOVE PRODUCT FROM LIST USING ID param:
  RemoveProduct({id, path}) async {
    final localStore = await SharedPreferences.getInstance();
    try {
      product_list.removeWhere((element) => element['id'] == id);
      deleteProductpath.add(path);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

///////////////////////////////////////////////////
  /// GETTING PRODUCT LIST :
  /// 1. CHECK IF PRODUCT IS STORE IN LOCAL STORAGE :
  /// 2. IF STORE THEN UPDATE product_list ;
  /// 3. INSTED OF CREATEING NEW LIST , WE USE UPDATE
  /// METHOD BZ OF product_list has Observer attach :
///////////////////////////////////////////////////
  GetProductList() async {
    product_list.clear();
    final localStore = await SharedPreferences.getInstance();
    try {
      // Check local store for product :
      bool is_detail = localStore.containsKey(getBusinessProductStoreName);
      if (is_detail) {
        // Retrive Product  then convert in list then update
        // Product list :
        var data = localStore.getString(getBusinessProductStoreName);
        var json_obj = jsonDecode(data!);

        var temp_list = json_obj['products'].toList();

        for (int i = 0; i < temp_list.length; i++) {
          product_list.add(temp_list[i]);
        }
        return product_list;

        // If there is no product then just add temp prodcut to list :
        // or send Set Products :
        // and send for example purpose :
      } else {
        return product_list;
      }

      // To Save widget from crash if error occure then send temp product:
    } catch (e) {
      return product_list;
    }
  }

  ///////////////////////////////////////////////////////////////
  // STORE PRODUCT LIST LOCALY : PERSIST DATA FOR FURTHUR USAGE:
  // USE LOCAL STORAGE :
  // CREATE PRODUCT MODEL WITH LIST OF PRODUCT IN JSON FORMAT :
  ///////////////////////////////////////////////////////////////
  PersistProduct({user_id}) async {
    final localStore = await SharedPreferences.getInstance();
    try {
      var resp = await BusinessProductsList(
        user_id: user_id,
        products: product_list,
      );

      localStore.setString(getBusinessProductStoreName, json.encode(resp));
      product_list.clear();
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
