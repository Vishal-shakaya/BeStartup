
// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

 
class MyFirebaseStore {
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  //////////////////////////////
  // FIRESBASE EMAIL LOGIN: 
  //////////////////////////////
  LoginUser({email, password}) async {
    final users = store.collection('users');
    try {
      users.add({
        'email': email,
        'password': password,
      });
    } catch (err) {
      print('UNABLE TO LOGIN ${err}');
    }
  }


    
}
