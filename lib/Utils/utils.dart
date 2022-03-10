
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

// CREATE RESPONSE ERROR OR SUCCESSFUL :

ResponseBack({required response_type, code=null, data=null, message=null}) async {
  var response; 
  // Error Response :
  if(!response_type){
    response = {
      'response': false,
      'code': code!=null?code:001,
      'message': message!=null? message : 'Something went wrong',
      'data': data!=null? data  :null 
    };
  }

  // Success response
  if(response_type){
    response = {
      'response': true,
      'code': code!=null?code:100,
      'message': message!=null? message : 'Successfull operation',
      'data': data!=null? data  :null 
    };
  }
  return response;
}


/// Shhow SnakBar

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
              ) ,
            )
          ],
        );
  }

  Row MySnackbarContent({message}) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${message}',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(),
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ) ,)
          ],
        );
  }