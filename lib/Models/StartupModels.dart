
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:get/get.dart';

var uuid = Uuid();

BusinessInfoModel({
  user_id, 
  logo, 
  name, 
  email,
  disire_amount,
  investor_no}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id, 
      'email': email,
      'logo': logo,
      'name': name,
      'desire_amount':disire_amount,
      'investor_no':investor_no
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

ThumbnailModel({
  thumbnail,
  user_id,
  email,
  startup_name,
}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email': email,
      'startup_name': startup_name,
      'thumbnail': thumbnail,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

VisionModel({user_id, email, vision, startup_name}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email': email,
      'startup_name': startup_name,
      'vision': vision,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

CatigoryModel({user_id, email, startup_name, catigory}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email': email,
      'startup_name': startup_name,
      'catigories': catigory
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


BusinessProductsList({user_id, email, startup_name,  products, timestamp}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email':email, 
      'startup_name':startup_name, 
      'timestamp': timestamp,
      'products': products,
    };
    return temp_obj;    
  } catch (e) {
    return false; 
  }
}

BusinessServiceList({user_id, email, startup_name, services, timestamp}) {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'timestamp': timestamp,
      'services': services
    };
    return temp_obj;    
  } catch (e) {
    return false; 
  }
}

MileStoneModel(
    {user_id,
    email,
    startup_name,
    milestone}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email': email,
      'startup_name': startup_name,
      'milestone':milestone
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


BusinessTeamMembersModel({
  user_id,
  email,
  startup_name,
  members,
  timestamp,  

})async{
 try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'startup_name':startup_name,
      'email': email,
      'members':members, 
      'timestamp':timestamp, 

    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}