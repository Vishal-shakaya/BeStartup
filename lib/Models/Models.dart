import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

var uuid = Uuid();

UserModel({email,is_profile_complete}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'email': email,
      'is_profile_complete':is_profile_complete
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

UserDetailModel(
    {email, 
    user_id,
    name,
    picture,
    phone_no,
    founder,
    investor,
    plan,
    position,
    }) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'position':position, 
      'email':email, 
      'name': name,
      'picture': picture,
      'founder': founder, // T/F
      'investor': investor, // T/F
      'plan': plan // plan id :
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

UserContact({user_id, email,  primary_main, other_contact, phone_no}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'primary_main': primary_main,
      'other_contact': other_contact,
      'phone_no': phone_no
    };
    return temp_obj;
  } catch (e) {
    return false; 
  }
}

PlanModel({name, buyer_mail, purchase_date, expire_date}) async {
  try {
    Map<String, dynamic> user = {
      'id': uuid.v4(),
      'name': name,
      'buyer': buyer_mail,
      'purchase_date': '', // T/F
      'expire_date': '', // T/F
    };
    return user;
  } catch (e) {
    return false;
  }
}

SaveIdeasModel({user_id, logo, name, email, timestamp}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'name': name,
      'email': email,
      'user_id': user_id,
      'timestamp': timestamp
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}
