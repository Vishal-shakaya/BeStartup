import 'package:be_startup/Utils/Images.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:get_storage/get_storage.dart';

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

  final box = GetStorage();

  ////////////////////////////////////////
  /// Setters :
  ////////////////////////////////////////
  SetPrimaryMail({required mail}) async {
    primary_mail = mail ?? '';
    print('Set  $primary_mail');
  }

  SetDefaultUserMail({required mail}) async {
    default_mail = mail ?? '';
    print('Set  $default_mail');
  }

  SetUserId({required id}) async {
    user_id = id ?? '';
    print('Set  $user_id');
  }

  SetUserType({required type}) async {
    user_type = type ?? '';
    await box.write('user_type', user_type);
    print('Set  $user_type');
  }

  IsAdmin({required admin}) async {
    is_admin = admin ?? '';
    print('Set  $admin');
  }

  SetProfileImage({required image}) async {
    profile_image = image ?? temp_avtar_image;
    print('Set  $image');
  }

  SetProfileName({required name}) async {
    profile_name = name ?? '';
    print('Set  $name');
  }

  SetPhoneNo({required number}) async {
    phoneNo = number ?? '';
    print('Set  $number');
  }

  SetOtherContact({required contact}) async {
    otherContact = contact ?? '';
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
    final user = box.read('user_type');
    return user;
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
