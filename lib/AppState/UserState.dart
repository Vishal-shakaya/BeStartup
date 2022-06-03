import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool? is_user_login_state;
////////////////////////////////////////////////
/// GETTERS : 
/// 1 username , email , id , startup name
////////////////////////////////////////////////
dynamic get getUserName async {
  final temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('loginUserName');
  return temp_obj; 
}

dynamic get getuserEmail async {
  final temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('loginUserEmail');
  return temp_obj; 
}

dynamic get getUserId async {
  final temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('loginUserId');
  return temp_obj; 
}

dynamic get getStartupName async {
  final temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('StartupName');
  return temp_obj; 
}


////////////////////////////////////////////////
/// SETTERS : 
/// 1 username , email , id , startup name
////////////////////////////////////////////////
 SetLoginUserName(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('loginUserName');

    if (!key_found) {
      final resp = await localStore.setString('loginUserName', value);
      if (resp) {
        print('PARAM SETED $value');
      }
    }
}

 SetLoginUserMail(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('loginUserEmail');

    if (!key_found) {
      final resp = await localStore.setString('loginUserEmail', value);
      if (resp) {
        print('PARAM SETED $value');
      }
    }
}


 SetLoginUserId(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('loginUserId');

  if (!key_found) {
    final resp = await localStore.setString('loginUserId', value);
    if (resp) {
      print('PARAM SETED $value');
    }
  }
}

 SetStartupName(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('StartupName');

   if (!key_found) {
      final resp = await localStore.setString('StartupName', value);
      if (resp) {
        print('PARAM SETED $value');
    }
  }
}

