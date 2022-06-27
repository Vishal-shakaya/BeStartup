import 'dart:convert';
import 'package:be_startup/Utils/utils.dart';
import 'package:http/http.dart' as http;

// Send mail in Background:
Future SendMailToUser(
    {transaction_id,
    plan_type,
    amount,
    order_date,
    expire_date,
    phone_no,
    subject,
    payer_name,
    receiver_mail_address}) async {
  final service_id = 'service_q3vcj0i';
  final template_id = 'template_ohh8cfn';
  final user_id = 'user_A0cQHMmF6wvMMep8H74Zu';
  var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  try {
    var response = await http.post(url,
        headers: {
          // important line to send mail phone device:
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          // Required params to send mail :
          'service_id': service_id,
          'template_id': template_id,
          'user_id': user_id,
          // Dynamic params in mail message :
          'template_params': {
            'transaction_id': transaction_id,
            'plan_type': plan_type,
            'amount': '₹${amount}',
            'order_date': order_date,
            'expire_date': expire_date,
            'phone_no': phone_no,
            'subject': subject,
            'payer_name': payer_name,
            'receiver_mail_address': receiver_mail_address,
          }
        }));

    return ResponseBack(response_type: true, message: response.body);
  } catch (error) {
    return ResponseBack(response_type: false,message: '[SEND FEEDBACK MAIL ERROR]$error');
  }
}
