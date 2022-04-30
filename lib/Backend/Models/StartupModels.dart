import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

var uuid = Uuid();

BusinessInfoModel({user_id, logo, name, email}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'logo': logo,
      'name': name,
      'email': email,
      'user_id': user_id
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

ThumbnailModel({
  logo,
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

Vision({user_id, email, vision, startup_name}) async {
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

CatigoryModel({user_id, email, startup_name, List<String>? catigory}) async {
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

ProductModel(
    {user_id,
    email,
    startup_name,
    image,
    youtube_link,
    content_link,
    heading,
    detail,
    timestamp}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email': email,
      'startup_name': startup_name,
      'youtube_link': youtube_link,
      'content_link': content_link,
      'heading': heading,
      'detail': detail,
      'timestamp': timestamp,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}

ServiceModel(
    {user_id,
    email,
    startup_name,
    image,
    youtube_link,
    content_link,
    heading,
    detail,
    timestamp}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email': email,
      'startup_name': startup_name,
      'youtube_link': youtube_link,
      'content_link': content_link,
      'heading': heading,
      'detail': detail,
      'timestamp': timestamp,
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
    List<String>? tags,
    List<String>? content}) async {
  try {
    Map<String, dynamic> temp_obj = {
      'id': uuid.v4(),
      'user_id': user_id,
      'email': email,
      'startup_name': startup_name,
      'tags': tags,
      'content': content,
    };
    return temp_obj;
  } catch (e) {
    return false;
  }
}
