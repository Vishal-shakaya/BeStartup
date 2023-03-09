
import 'package:be_startup/Utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

var uuid = Uuid();

UserModel({
 required email,
 required is_profile_complete, 
 required id , 
 required user_type, 
 }) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': id,
      'email': email,
      'is_profile_complete':is_profile_complete,
      'user_type':user_type, 
      'timestamp':await GetFormatedDate() 
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}



InvestorModel({
    required email, 
    required user_id,
    required name,
    required picture,
    required phone_no,
    required primary_mail,
    required other_contact,  
    }) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email':email, 
      'name': name,
      'picture': picture,
      'primary_mail': primary_mail,
      'other_contact': other_contact,
      'phone_no': phone_no, 
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}



FounderModel({
    required email, 
    required user_id,
    required name,
    required picture,
    required primary_mail , 
    required other_contact,
    phone_no,
    }) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email':email, 
      'name': name,
      'picture': picture,
      'primary_mail': primary_mail,
      'other_contact': other_contact,
      'phone_no': phone_no, 
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}



UserContact({user_id, email,  primary_mail, other_contact, phone_no}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'primary_mail': primary_mail,
      'other_contact': other_contact,
      'phone_no': phone_no
    };
    return temp_obj;
  } catch (e) {
    return false; 
  }
}



PlanModel({
  required user_id, 
  required plan_name,
  required buyer_mail, 
  required buyer_name, 
  required order_date, 
  required expire_date ,
  required amount ,
   tax='',
  phone_no, 
  }) async {
  try {
    Map<String, dynamic> plan = {
      'user_id':user_id, 
      'id': uuid.v4(),
      'name': plan_name,
      'buyer_mail': buyer_mail,
      'buyer_name':buyer_name, 
      'phone_no':phone_no, 
      'amount':amount, 
      'tax':tax, 
      'activate_date':order_date,
      'expire_date':expire_date , 
    };
    return plan;
  } catch (e) {
    return false;
  }
}


SaveStartupsModel({required user_id, required user_ids}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'user_ids':user_ids,
      'timestamp': DateTime.now().toString()
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


LikeStartupsModel({user_id, timestamp,user_ids}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'user_ids':user_ids,
      'timestamp': DateTime.now().toString()
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}
