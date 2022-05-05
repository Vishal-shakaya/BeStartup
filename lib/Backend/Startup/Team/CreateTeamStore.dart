import 'dart:convert';

import 'package:be_startup/AppState/UserState.dart';
import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Models/StartupModels.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

var uuid = Uuid();

class BusinessTeamMemberStore extends GetxController {
  static Map<String, dynamic> temp_member = {
    'id': uuid.v4(),
    'email': getuserEmail,
    'startup_name': getStartupName,
    'name': 'Vishal',
    'position': 'Ceo',
    'member_mail': 'shakayavishal007@gmail.com',
    'meminfo': feature1_body,
    'image': temp_image,
    'timestamp': DateTime.now().toString(),
  };

  static Map<String, dynamic>? member;
  static String? profile_image;

  RxList member_list = [].obs;

  // SET PROFILE IMAGE :
  SetProfileImage(image) async {
    profile_image = image;
  }

  // UPLOADING PROFILE :
  UploadProductImage({image, filename}) async {
    try {
      // STORE IMAGE IN FIREBASE :
      // AND GET URL OF IMAGE AFTER UPLOAD IMAGE :
      profile_image = await UploadImage(image: image, filename: filename);

      // RETURN SUCCES RESPONSE WITH IMAGE URL :
      return ResponseBack(response_type: true, data: profile_image);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // CREATE MEMEBER WITH REQUIRED DETAIL :
  CreateTeamMember(member) async {
    try {
      Map<String, dynamic> temp_member = {
        'id': uuid.v4(),
        'email': getuserEmail,
        'startup_name': getStartupName,
        'name': member['name'],
        'position': member['position'],
        'member_mail': member['email'],
        'meminfo': member['meminfo'],
        'image': profile_image,
        'timestamp': DateTime.now().toString(),
      };
      member = temp_member;
      member_list.add(member);
      profile_image = null;
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  UpdateTeamMember(member, index) async {
    try {
      Map<String, dynamic> temp_member = {
        'name': member['name'],
        'position': member['position'],
        'member_mail': member['email'],
        'meminfo': member['meminfo'],
        'image': profile_image,
        'timestamp': DateTime.now().toString(),
      };
      member_list[index] = temp_member;
      profile_image = null;
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  // DELETE MEMBER FORM LIST :
  RemoveMember(id) async {
    member_list.removeWhere((element) => element!['id'] == id);
  }

  // GET MEMBERS
  GetMembers() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      // Check local store for product :
      bool is_detail = localStore.containsKey('BusinessTeamMember');
      if (is_detail) {
        // Retrive Product  then convert in list then update
        // Product list :
        var data = localStore.getString('BusinessTeamMember');
        var json_obj = jsonDecode(data!);

        var temp_list = json_obj['members'].toList();
        for (int i = 0; i < temp_list.length; i++) {
          member_list.add(temp_list[i]);
        }
        return member_list;

        // If there is no product then just add temp prodcut to list :
        // and send for example purpose :
      } else {
        member_list.add(temp_member);
        return member_list;
      }

      // To Save widget from crash if error occure then send temp product:
      // print error :
    } catch (e) {
      print('Error While Get Milestones ${e}');
      return false;
    }
  }

  // STORE MEMBER TO LOCAL STORAGE :
  PersistMembers() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      var resp = await BusinessTeamMembersModel(
        user_id: getUserId,
        email: getuserEmail,
        startup_name: getStartupName,
        members: member_list,
      );

      localStore.setString('BusinessTeamMember', json.encode(resp));

      // Remove Dublication for local storage and cache storage: 
      member_list.clear();
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
