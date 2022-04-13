import 'package:be_startup/Backend/Firebase/ImageUploader.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BusinessTeamMemberStore extends GetxController {
  static Map<String, dynamic> temp_member = {
    'id': UniqueKey(),
    'user': '',
    'name': 'Vishal',
    'position': 'Ceo',
    'email': 'shakayavishal007@gmail.com',
    'meminfo': feature1_body,
    'image': temp_image,
    'timestamp': DateTime.now().toString(),
  };
  static Map<String, dynamic>? member;
  static String? profile_image;
  List<Map<String, dynamic>?> member_list = [temp_member].obs;

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
        'id': UniqueKey(),
        'user': '',
        'name': member['name'],
        'position': member['position'],
        'email': member['email'],
        'meminfo': member['meminfo'],
        'image': profile_image,
        'timestamp': DateTime.now().toString(),
      };
      member = temp_member;
      profile_image = null;
      member_list.add(member);
      return ResponseBack(response_type: true);
    } catch (e) {
      return ResponseBack(response_type: false);
    }
  }

  UpdateTeamMember(member, index) async {
    try {
      Map<String, dynamic> temp_member = {
        'id': member['id'],
        'user': '',
        'name': member['name'],
        'position': member['position'],
        'email': member['email'],
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
  GetMembers() {
    try {
      return member_list;
    } catch (e) {
      return [];
    }
  }
}
