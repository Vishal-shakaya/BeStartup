
import 'package:be_startup/Utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
var uuid = Uuid();


BusinessDetailMode({
  required logo, 
  required name, 
  required desire_amount, 
  required user_id, 
  invested,
  activate, 
  startup_search_index, 
  founder_search_index, 
  achived_amount ="0", 
}) async {
    try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'logo':logo, 
      'name': name,
      'desire_amount': desire_amount,
      'achived_amount':achived_amount, 
      'activate':activate, // check if startup plan expired or not :  
      'startup_searching_index':startup_search_index, 
      'founder_searching_index':founder_search_index, 
      'invested':invested,
      'timestamp': await GetFormatedDate() 
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


ThumbnailModel({
  required thumbnail,
  required user_id , 
}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'thumbnail': thumbnail,
      'user_id':user_id
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}



VisionModel({
required vision,
required user_id,  
}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id, 
      'vision': vision,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


PitchModel({
pitch, 
required user_id}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id, 
      'pitch': pitch,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

WhyInvestModel({
  why_text,
  required user_id}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'why_text': why_text,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}




CatigoryModel(
  {
  required user_id,   
  catigory}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'catigories': catigory,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}
// InvestorCatigoryModel(
//   {
//   user_id,   
//   catigory}) async {
//   try {
//     Map<String, dynamic> temp_obj = {
//       'id': uuid.v4(),
//       'user_id': user_id,
//       'catigories': catigory,
//       'timestamp':await GetFormatedDate()
//     };
//     return temp_obj;
//   } catch (e) {
//     return false;
//   }
// }


BusinessProductsList({
required user_id, 
products}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'products': products,
      'user_id':user_id
    };

    return temp_obj;    
  } catch (e) {
    return false; 
  }
}

BusinessServiceList({user_id, required startup_id,  services,})async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'startup_id':startup_id, 
      'services': services, 
      'timestamp':await GetFormatedDate(),
    };
    return temp_obj;    
  } catch (e) {
    return false; 
  }
}


MileStoneModel(
    {
    required user_id,   
    milestone}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id':user_id, 
      'milestone':milestone
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


BusinessTeamMembersModel({
  required user_id, 
  members,
  timestamp,  

})async{
 try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'members':members, 
      'timestamp':await GetFormatedDate() , 

    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}


// id is required field :
StartupInvestorModel({required user_id, required investor,required id})async{
 try {
    Map<String, dynamic> temp_obj = {
      'id': id,
      'user_id': user_id,
      'investor':investor, 
      'timestamp':await GetFormatedDate() , 

    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

