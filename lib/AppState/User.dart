
import 'package:be_startup/Utils/Images.dart';

class UserState {
  static var primary_mail;
  static var default_mail;
  static var user_id;
  static var user_type;
  static var is_admin;
  static var profile_image;
  static var profile_name;
  static var phoneNo;
  static var otherContact;

  ////////////////////////////////////////
  /// Setters :
  ////////////////////////////////////////
  SetPrimaryMail({required mail}) async {
    primary_mail = mail??'';
    print('Set  $mail');
  }

  SetDefaultUserMail({ required mail}) async {
    default_mail = mail??'';
    print('Set  $mail');
  }

  SetUserId({required id}) async {
    user_id = id??'';
    print('Set  $id');
  }


  SetUserType({required type}) async {
    user_type = type??'';
    print('Set  $type');
  }

  IsAdmin({required admin}) async {
    is_admin = admin??'';
    print('Set  $admin');
  }

  SetProfileImage({required image}) async {
    profile_image = image??temp_avtar_image;
    print('Set  $image');
  }

  SetProfileName({required name}) async {
    profile_name = name??'';
    print('Set  $name');
  }

  SetPhoneNo({required number}) async {
    phoneNo = number??'';
    print('Set  $number');
  }

  SetOtherContact({required contact}) async {
    otherContact = contact??'';
    print('Set  $contact');
  }



  /////////////////////////////////////////
  /// Getter :
  /////////////////////////////////////////

  GetPrimaryMail() async {
    return primary_mail;
  }
  
  GetDefaultMail() async {
    return default_mail;
  }
  
  GetUserId() async {
    return user_id;
  }
  
  GetUserType() async {
    return user_type;
  }

  GetIsUserAdmin() async {
    return is_admin;
  }

  GetProfileImage() async {
    return profile_image;
  }

  GetProfileName() async {
    return profile_name;
  }

  GetPhoneNo() async {
    return phoneNo;
  }

  GetOtherContact() async {
    return otherContact;
  }


  
}
