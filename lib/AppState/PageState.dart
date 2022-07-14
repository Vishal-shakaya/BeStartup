
import 'package:shared_preferences/shared_preferences.dart';

///////////////////////////////////////////
/// Story Detiail view Getters : 
///////////////////////////////////////////


dynamic get getIsUserAdmin async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getBool('IsUserAdmin');
  return temp_obj;
}



dynamic get getStartupFounderId async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('StartupFounderId');
  return temp_obj;
}



dynamic get getStartupDetailViewId async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('StartupDetailViewId');
  return temp_obj;
}

////////////////////////////////////////////////
/// Startup Detail view Setters : 
////////////////////////////////////////////////



SetStartupFounderId(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('StartupFounderId');
  final resp = await localStore.setString('StartupFounderId', value);
  if (resp) {
    print('PARAM SETED $value');
  }
}



SetIsUserAdmin(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('IsUserAdmin');
  final resp = await localStore.setBool('IsUserAdmin', value);
  if (resp) {
    print('PARAM SETED $value');
  }
}


SetStartupDetailViewId(value) async {
  final localStore = await SharedPreferences.getInstance();
  final key_found = localStore.containsKey('StartupDetailViewId');
  final resp = await localStore.setString('StartupDetailViewId', value);
  if (resp) {
    print('PARAM SETED $value');
  }
}