import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum ProductType {
  service,
  product,
}

class BusinessProductStore extends GetxController {
  // Test Product :
  static Map<String, dynamic?> temp_product = {
    'id': UniqueKey(),
    'title': 'word famous watter battle and cleane',
    'description': long_string,
    'type': 'product',
    'image_url': temp_image,
    'timestamp': DateTime.now().toString(),
    'youtube_link': 'https://www.youtube.com/watch?v=-ImJeamG0As',
    'content_link': 'https://www.youtube.com/watch?v=-ImJeamG0As',
    'belong_to': '',
    'catigory': '',
  };

  List<Map<String, dynamic?>> product_list = [temp_product].obs;
  static String? image_url;
  static String? product_type = 'product';
  static String? youtube_link = '';
  static String? content_link = '';
  late ProductType prod_type;

  // Setting youtube link :
  SetYoutubeLink(link) async {
    try {
      youtube_link = link;
      print('youtube link set');
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // Setting product content Link :
  SetContentLink(link) async {
    try {
      content_link = link;
      print('content link set');
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
      print('PRODUCT TYPE ${product_type}');
      print('product set');
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  SetImageUrl(image) async {
    try {
      image_url = image;
      print('image set');
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // ADD PRODUCT :
  CreateProduct({title, description}) {
    Map<String, dynamic?> product = {
      'id': UniqueKey(),
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
    print('Before ${product_list}');
    try {
      product_list.removeWhere((element) => element['id'] == id);
      print('After ${product_list}');
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  //////////////////////
  /// GETTERS :
  /// ///////////////////

  // Get All Products :
  GetProductList() {
    try {
      return product_list;
    } catch (e) {
      return [];
    }
  }
}
