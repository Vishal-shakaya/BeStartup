import 'package:be_startup/AppState/StartupState.dart';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Backend/CacheStore/CacheStore.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessDetailStore.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BusinessFounderStore extends GetxController {
  var userState = Get.put(UserState());
  var startupState = Get.put(StartupDetailViewState());
  var businessDetailStore = Get.put(BusinessDetailStore());

  static Map<String, dynamic>? founder;

  static var image_url;
  static var picture = '';
  static var name = '';
  static var position = '';
  static var phone_no = '';
  static var primary_mail = '';
  static var other_contact = '';

  static Map<String, dynamic> founder_obj = {
    'picture': picture,
    'name': name,
    'position': position,
    'phone_no': phone_no,
    'primary_mail': primary_mail,
    'other_contact': other_contact,
  };

  SetFounderParam({data}) async {
    founder_obj.clear();
    await RemoveCachedData(key: getBusinessFounderDetailStoreName);
    await RemoveCachedData(key: getBusinessFounderContactStoreName);

    // picture = data['picture'];
    name = data['name'];
    position = data['position'];
    phone_no = data['phone_no'];
    primary_mail = data['primary_mail'];
    other_contact = data['other_contact'];

    founder_obj['name'] = name;
    founder_obj['position'] = position;
    founder_obj['phone_no'] = phone_no;
    founder_obj['primary_mail'] = primary_mail;
    founder_obj['other_contact'] = other_contact;
  }

//////////////////////////////////////////////////
  /// It takes a picture from the camera, and then
  /// sets the picture to the founder_obj['picture'] variable
  ///
  /// Args:
  ///   data: The image data
//////////////////////////////////////////////////
  SetFounderPicture({data}) async {
    founder_obj['picture'] = data;
    picture = data;
  }

//////////////////////////////////////////////
  /// It returns a Future object that
  /// contains a Founder object
  ///
  /// Returns:
  ///   The return value is a Future&lt;Founder&gt;.
//////////////////////////////////////////////
  GetFounderParam() async {
    return founder_obj;
  }

  GetFounderPicture() async {
    return picture;
  }

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

  // CRATE FOUNDER :
  CreateFounder(founder) async {
    var localStore = await SharedPreferences.getInstance();

    try {
      try {
        var resp = await FounderModel(
            user_id: await userState.GetUserId(),
            email: await userState.GetDefaultMail(),
            startup_name: await startupState.GetStartupName(),
            name: founder['name'],
            position: founder['position'],
            picture: image_url);

        var resp2 = await UserContact(
            user_id: await userState.GetUserId(),
            email: await userState.GetDefaultMail(),
            primary_mail: founder['email'],
            phone_no: founder['phone_no'],
            other_contact: founder['other_contact']);

        localStore.setString(
            getBusinessFounderDetailStoreName, json.encode(resp));
        localStore.setString(
            getBusinessFounderContactStoreName, json.encode(resp2));

        ///////////////////////////////////////////
        // Updating BusinessDetial Field
        // 1. Founder name and search index :
        ///////////////////////////////////////////
        final founder_name_search_index =
            await CreateSearchIndexParam(founder['name']);

        await businessDetailStore.UpdateBusinessDetailCacheField(
            field: 'founder_name', val: founder['name']);

        await businessDetailStore.UpdateBusinessDetailCacheField(
            field: 'founder_searching_index', val: founder_name_search_index);

        return ResponseBack(response_type: true, message: create_error_title);
      } catch (e) {
        ResponseBack(response_type: false, message: e);
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  GetFounderDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      bool is_detail =
          localStore.containsKey(getBusinessFounderDetailStoreName);
      bool is_contanct =
          localStore.containsKey(getBusinessFounderContactStoreName);
      if (is_detail && is_contanct) {
        var detail = localStore.getString(getBusinessFounderDetailStoreName);
        var contact = localStore.getString(getBusinessFounderContactStoreName);

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
        return founder_obj;
      }
    } catch (e) {
      return founder_obj;
    }
  }

  SetFounderDetail({detail, contact}) async {
    final localStore = await SharedPreferences.getInstance();
    try {
      var detail_obj = jsonDecode(detail!);
      var contact_obj = jsonDecode(contact!);
      founder_obj = {
        'picture': detail_obj['picture'],
        'name': detail_obj['name'],
        'position': detail_obj['position'],
        'phone_no': contact_obj['phone_no'],
        'primary_mail': contact_obj['primary_mail'],
        'other_contact': contact_obj['other_contact'],
      };
    } catch (e) {
      return founder_obj;
    }
  }
}
