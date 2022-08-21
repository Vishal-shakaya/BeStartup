import 'dart:convert';

import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

double alert_width = 320;
final snackbar_show_time = 4;

List<String> business_catigories = [
  'Software Dev',
  'IT Industry',
  'Hacking',
  'Marketing',
  'Socail Media',
  'NGO',
  'Trend',
  'Selling',
  'Manugacture',
  'Gamer',
  'Textile',
  'Software Dev',
  'IT Industry',
  'Hacking',
  'Marketing',
  'Socail Media',
  'NGO',
  'Trend',
  'Selling',
  'Manugacture',
  'Gamer',
  'Textile',
  'Software Dev',
  'IT Industry',
  'Hacking',
  'Marketing',
  'Socail Media',
  'NGO',
  'Trend',
  'Selling',
  'Manugacture',
  'Gamer',
  'Textile',
];

final localStorageKeyes = [
  'loginUserName',
  'loginUserEmail',
  'loginUserId',
  'StartupName',
  'DesireAmount',
  'StartupId'
];

final startupSlideStorageKeys = [
  getBusinessDetailStoreName,
  getBusinessCatigoryStoreName,
  getBusinessMilestoneStoreName,
  getBusinessProductStoreName,
  getBusinessVisiontStoreName,
  getBusinessWhyInvesttStoreName,
  getBusinessThumbnailStoreName,
  getBusinessTeamMemberStoreName,
  getBusinessFounderContactStoreName,
  getBusinessFounderDetailStoreName,
  getStartupPlansStoreName,
  getStartupStoreName, 
  getInvestorUserDetail, 
  getInvestorUserContacts, 
  getInvestorUserChooseCatigory , 
  getBusinessFounderDetailStoreName,
  getBusinessFounderContactStoreName,  
];

////////////////////////////////////////////
// CREATE RESPONSE ERROR OR SUCCESSFUL :
////////////////////////////////////////////
ResponseBack(
    {required response_type, code = null, data = null, message = null}) {
  var response;
  // Error Response :
  if (!response_type) {
    response = {
      'response': false,
      'code': code != null ? code : 001,
      'message': message != null ? message : 'Something went wrong',
      'data': data != null ? data : null
    };
  }

  // Success response
  if (response_type) {
    response = {
      'response': true,
      'code': code != null ? code : 100,
      'message': message != null ? message : 'Successfull operation',
      'data': data != null ? data : null
    };
  }
  return response;
}

///////////////////////////////////
/// Snackbar Component :
//////////////////////////////////
Row MySnackbarTitle({title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '${title}',
        style: GoogleFonts.robotoSlab(
          textStyle: TextStyle(),
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      )
    ],
  );
}

Row MySnackbarContent({message = 'processing... '}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '${message}',
        style: GoogleFonts.openSans(
          textStyle: TextStyle(),
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      )
    ],
  );
}

////////////////////////////////////////////////
/// Custom SnackBar of handle :
/// 1. Error  , Success
/// 2. Custom message and title :
/// //////////////////////////////////////////

MyCustSnackbar({context, title, message, type, required width}) {
  var snack;
  // var snack_width = MediaQuery.of(context).size.width * 0.50;
  try {
    // ERROR SNACK :
    if (type == MySnackbarType.error) {
      snack = GetSnackBar(
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(top: 10),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red.shade50,
        titleText:
            MySnackbarTitle(title: title != null ? title : common_error_title),
        messageText: MySnackbarContent(
            message: message != null ? message : common_error_msg),
        maxWidth: width,
      );
      return snack;
    }

    // SUCCESS SNACK :
    if (type == MySnackbarType.success) {
      snack = GetSnackBar(
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(top: 10),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green.shade50,
        titleText:
            MySnackbarTitle(title: title != null ? title : snack_success_msg),
        messageText: MySnackbarContent(message: message != null ? message : ''),
        maxWidth: width,
      );
      return snack;
    }

    // INFOR SNACK :  :
    if (type == MySnackbarType.info) {
      snack = GetSnackBar(
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(top: 10),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue.shade50,
        titleText:
            MySnackbarTitle(title: title != null ? title : snack_info_msg),
        messageText: MySnackbarContent(message: message != null ? message : ''),
        maxWidth: width,
      );
      return snack;
    }
  } catch (e) {
    print('Snackbar Creating Error $e');
  }
}

////////////////////////////////////////////
/// MY CUSTOM LOADING SPINNER :
////////////////////////////////////////////
MyCustomButtonSpinner({color, width}) {
  var spinner = Container(
    margin: EdgeInsets.all(1),
    child: CircularProgressIndicator(
      color: color != null ? color : dartk_color_type3,
      strokeWidth: width != null ? width : 4,
    ),
  );
  return spinner;
}

MyCustPageLoadingSpinner() {
  var dialog = SmartDialog.showLoading(
      background: Colors.white,
      maskColorTemp: Color.fromARGB(146, 252, 250, 250),
      widget: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.orangeAccent,
      ));
  return dialog;
}

CloseCustomPageLoadingSpinner() {
  SmartDialog.dismiss();
}

////////////////////////////////////////////////////////
/// ERROR PAGE :
////////////////////////////////////////////////////////
class ErrorPage extends StatefulWidget {
  ErrorPage({Key? key}) : super(key: key);
  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Something went wrong'),
      ),
    );
  }
}

////////////////////////////////////////////////////
/// Custom Chimmer for loading :
/// 1. Take widget for shape shimmer:
/// 2. Take text or show text shimmer :
/////////////////////////////////////////////////////
class CustomShimmer extends StatefulWidget {
  Widget? shape = null;
  String? text;
  CustomShimmer({this.text, this.shape, Key? key}) : super(key: key);
  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer> {
  @override
  Widget build(BuildContext context) {
    String text = 'Loading...';
    if (widget.text!.isNotEmpty) {
      text = widget.text!;
    }

    Widget mainWidget = Text(
      text,
      style: Get.textTheme.headline2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );

    if (widget.shape != null) {
      mainWidget = widget.shape!;
    }
    return Center(
        child: Shimmer.fromColors(
      baseColor: shimmer_base_color,
      highlightColor: shimmer_highlight_color,
      child: mainWidget,
    ));
  }
}


///////////////////////////////////////
// Search Index Creator :
///////////////////////////////////////
CreateSearchIndexParam(String val)  {
  String pureString = val.toLowerCase().trim();
  var searchIndexArray = [];
  var temp =''; 
  
  for (var i = 0; i < pureString.length; i++) {
    if (pureString[i] != ' ') {
       temp = temp + pureString[i];
      searchIndexArray.add(temp);
    }
  }
  return searchIndexArray;
}

/////////////////////////////////////////////////////////
/// If the primary_mail is not empty, then set 
/// the primary_mail to the mail variable and return the mail
/// variable. 
/// If the primary_mail is empty, then set the
///  default_mail to the mail variable and return the mail
/// variable.
/// 
/// Args:
///   primary_mail: String
///   default_mail: the default mail of the user
/// 
/// Returns:
///   The return value is a Future&lt;String&gt;.
/////////////////////////////////////////////////////////
CheckAndGetPrimaryMail({required primary_mail , required default_mail})async {
var userState = Get.put(UserState());
var mail = default_mail; 
if (primary_mail != ''){
  mail = primary_mail;
  await userState.SetPrimaryMail(mail: mail);
  return mail; 
  }
}




/////////////////////////////////////
/// Get Formated Date : 
/////////////////////////////////////
  GetFormatedDate() async {
    try {
      var today  = DateTime.now().toString();
      // final DateFormat formatter = DateFormat('yyyy-MM-dd');
      // final String formatted = formatter.format(today);
    
      return today;
    } catch (err) {
      return '';
    }
  }










////////////////////////////////////////
// CUSTOM CACHING  SYSTEM :
// GET DATA FROM LOCAL STORGE
////////////////////////////////////////
GetCachedData({fromModel, startup_id}) async {
  final localStore = await SharedPreferences.getInstance();
  var is_localy_store = localStore.containsKey(fromModel);
  if (is_localy_store) {
    var data = localStore.getString(fromModel);

    // Validata data :
    if (data != null || data != '') {
      var final_data = json.decode(data!);
      Map<String, dynamic> cacheData = final_data as Map<String, dynamic>;
      if (cacheData['startup_id'] == startup_id) {
        return final_data;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } else {
    return false;
  }
}

//////////////////////////////////////////
// Cached Update Data :
//////////////////////////////////////////
StoreCacheData({fromModel, data}) async {
  try {
    final localStore = await SharedPreferences.getInstance();
    if (data != null || data != '') {
      localStore.setString(fromModel, json.encode(data));
      print('Cached Data Successfully');
      return true;
    }
  } catch (e) {
    return false;
  }
}
