import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

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
  'StartupName'
];

////////////////////////////////////////////
// CREATE RESPONSE ERROR OR SUCCESSFUL :
////////////////////////////////////////////
ResponseBack(
    {required response_type, code = null, data = null, message = null}) async {
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
    if (type == MySnackbarType.error) {
    // Error Snackbar:
       snack = GetSnackBar(
        snackPosition:SnackPosition.TOP ,
        margin: EdgeInsets.only(top: 10),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red.shade50,
        titleText: MySnackbarTitle(title: title != null ? title : 'Error accured'),
        messageText: MySnackbarContent(
            message: message != null ? message : 'Something went wrong'),
        maxWidth: width,
      );
      return snack;
    }

    if (type == MySnackbarType.success) {
    // Success Snackbar : 

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
    padding: EdgeInsets.all(8),
    child: CircularProgressIndicator(
      color: color != null ? color : dartk_color_type3,
      strokeWidth: width != null ? width : 4,
    ),
  );
  return spinner;
}

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

class CustomShimmer extends StatefulWidget {
  Widget? shape = null;
  String? text;
  CustomShimmer({this.text, this.shape, Key? key}) : super(key: key);
  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

//  CUSTOM SHIMMER :
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
