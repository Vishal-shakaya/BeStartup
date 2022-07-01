import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? is_user_login_state;
////////////////////////////////////////////////
/// GETTERS :
/// 1 username , email , id , startup name ,
/// desire amount:
////////////////////////////////////////////////
dynamic get getUserName async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('loginUserName');
  return temp_obj;
}

dynamic get getuserEmail async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('loginUserEmail');
  return temp_obj;
}

dynamic get getUserId async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('loginUserId');
  return temp_obj;
}

dynamic get getStartupName async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('StartupName');
  return temp_obj;
}

dynamic get getDesireAmount async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('DesireAmount');
  return temp_obj;
}

dynamic get getStartupId async {  
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('StartupId');
  return temp_obj;
}

////////////////////////////////////////////////
/// SETTERS :
/// 1 username , email , id , startup name
////////////////////////////////////////////////
SetLoginUserName(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('loginUserName');
  final resp = await localStore.setString('loginUserName', value);
  if (resp) {
    print('PARAM SETED $value');
  }
}

SetLoginUserMail(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('loginUserEmail');

  final resp = await localStore.setString('loginUserEmail', value);
  if (resp) {
    print('PARAM SETED $value');
  }
}

SetLoginUserId(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('loginUserId');
  final resp = await localStore.setString('loginUserId', value);
  if (resp) {
    print('PARAM SETED $value');
  }
}

SetStartupName(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('StartupName');
  final resp = await localStore.setString('StartupName', value);
  if (resp) {
    print('PARAM SETED $value');
  }
}

SedDesireAmount(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('DesireAmount');
  final resp = await localStore.setString('DesireAmount', value);
  if (resp) {
    print('PARAM SETED $value');
  }

}

  SetStartupId(value) async {
    final localStore = await SharedPreferences.getInstance();
    final key_found = localStore.containsKey('StartupId');
    final resp = await localStore.setString('StartupId', value);
    if (resp) {
      print('PARAM SETED $value');
    }
  }
