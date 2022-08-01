import 'package:be_startup/AppState/UserState.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

var uuid = Uuid();

UserModel({email,
 is_profile_complete, 
 id , 
 plan,startups,
 is_founder,
 is_investor}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': id,
      'email': email,
      'is_profile_complete':is_profile_complete,
      'plan':plan,  // list
      'startups':startups, // list
      'is_investor':is_investor, 
      'is_founder':is_founder
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

InvestorModel(
    {email, 
    user_id,
    name,
    picture,
    phone_no,
    position,
    }) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email':email, 
      'name': name,
      'picture': picture,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

FounderModel(
    {email, 
    user_id,
    name,
    picture,
    phone_no,
    founder,
    investor,
    plan,
    position,
    startup_name
    }) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'startup_name':startup_name,  
      'name': name,
      'position':position, 
      'email':email, 
      'picture': picture,
      'plan': plan // plan id :
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
  required startup_id,
  required user_id, 
  plan_name,
  phone_no, 
  buyer_mail, 
  order_date, 
  expire_date ,
  amount ,
  tax,buyer_name}) async {
  try {
    Map<String, dynamic> plan = {
      'id': uuid.v4(),
      'startup_id':startup_id,
      'user_id':user_id,
      'plan_name': plan_name,
      'buyer_mail': buyer_mail,
      'buyer_name':buyer_name, 
      'phone_no':phone_no, 
      'amount':amount, 
      'tax':tax, 
      'order_date':order_date,
      'expire_date':expire_date , 
    };
    return plan;
  } catch (e) {
    return false;
  }
}


SaveStartupsModel({user_id, timestamp,startup_ids}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'startup_ids':startup_ids,
      'timestamp': DateTime.now().toString()
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}
