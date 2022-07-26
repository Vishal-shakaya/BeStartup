
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:get/get.dart';

var uuid = Uuid();

StartupModel({
  required user_id,
  required email,
  required startup_name,
   timestamp,  
})async{
 try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email': email,
      'startup_name':startup_name,
      'timestamp':timestamp, 
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


BusinessInfoModel({
  startup_id, 
  logo, 
  name, 
  investor_no, 
  timestamp,  
  desire_amount, 
  achived_amount,
  invested,
  team_members,
  founder_name, 
  activate, }) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'team_members':team_members, 
      'startup_id':startup_id,
      'logo': logo,
      'name': name,
      'founder_name':founder_name, 
      'investor_no':investor_no,
      'desire_amount':desire_amount, 
      'achived_amount':achived_amount, 
      'invested':invested, // bool : true if achived desired amount : 
      'registor_date':DateTime.now().toString(), 
      'activate':activate, // check if startup plan expired or not :  
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


ThumbnailModel({
  thumbnail,
  required startup_id, 
  startup_name,
}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'startup_id':startup_id, 
      'thumbnail': thumbnail,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}



VisionModel({
vision, 
required startup_id}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'startup_id': startup_id, 
      'vision': vision,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

WhyInvestModel({
  why_text,
  required startup_id}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'startup_id': startup_id,
      'why_text': why_text,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


CatigoryModel(
  {
  startup_id,   
  catigory}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'startup_id': startup_id,
      'catigories': catigory
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


InvestorCatigoryModel(
  {
  user_id,   
  catigory}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'catigories': catigory
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


BusinessProductsList({
required startup_id, 
products}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'startup_id':startup_id, 
      'products': products,
      'timestamp': '',

    };
    return temp_obj;    
  } catch (e) {
    return false; 
  }
}

BusinessServiceList({user_id, required startup_id,  services,}) {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'startup_id':startup_id, 
      'services': services, 
      'timestamp': '',
    };
    return temp_obj;    
  } catch (e) {
    return false; 
  }
}


MileStoneModel(
    {
    required startup_id,   
    milestone}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'startup_id':startup_id, 
      'milestone':milestone
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


BusinessTeamMembersModel({
  required startup_id, 
  members,
  timestamp,  

})async{
 try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'startup_id': startup_id,
      'members':members, 
      'timestamp':timestamp, 

    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

