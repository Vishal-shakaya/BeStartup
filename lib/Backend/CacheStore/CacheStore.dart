import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart';

var key = Key.fromSecureRandom(32);
var iv = IV.fromSecureRandom(16);
var encrypter = Encrypter(AES(key));

getMycachedData({required key}) async {
  var temp_obj;
  final localStore = await SharedPreferences.getInstance();
  temp_obj = await localStore.getString('$key');
  final desc = Encrypted.from64(temp_obj);
  final decrypted = encrypter.decrypt(desc, iv: iv);
  return decrypted;
}

CachedMyData({required key, required value}) async {
  final encrypted = encrypter.encrypt(value, iv: iv);
  final descrypt = encrypter.decrypt(encrypted, iv: iv);

  final localStore = await SharedPreferences.getInstance();
  final resp = await localStore.setString('$key', encrypted.base64);
  if (resp) {
    print('Descrytp Param Set $descrypt');
  }
}
