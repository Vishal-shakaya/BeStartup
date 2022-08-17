import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart';

var key = Key.fromSecureRandom(32);
var iv = IV.fromSecureRandom(16);
var encrypter = Encrypter(AES(key));

////////////////////////////////////////////////////////////
/// It takes a key as a parameter, gets the encrypted
/// data from the local storage, decrypts it and
/// returns the decrypted data
/// Args:
///   key: The key to be used to store the data.
/// Returns:
///   A string.
////////////////////////////////////////////////////////////
getMycachedData({required key}) async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('$key');
  final desc = Encrypted.from64(temp_obj);
  final decrypted = encrypter.decrypt(desc, iv: iv);
  return decrypted;
}



//////////////////////////////////////////////////////////
/// It takes a key and a value, encrypts the value,
/// stores the encrypted value in the local storage, and
/// returns the decrypted value
/// Args:
///   key: The key to store the data under.
///   value: The value to be encrypted.
//////////////////////////////////////////////////////////
CachedMyData({required key, required value}) async {
  final encrypted = encrypter.encrypt(value, iv: iv);
  final descrypt = encrypter.decrypt(encrypted, iv: iv);

  final localStore = await SharedPreferences.getInstance();
  final resp = await localStore.setString('$key', encrypted.base64);
  if (resp) {
    print('Set $descrypt');
  }
}



/// It removes the cached data from the local storage
/// 
/// Args:
///   key: The key of the data you want to remove.
RemoveCachedData({required key}) async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  final is_contain = await localStore.containsKey(key);
  
  if(is_contain){
    temp_obj = await localStore.remove('$key');
  }
}
