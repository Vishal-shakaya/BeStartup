class UserStateView {
  static var primary_mail;

  ////////////////////////////////////////
  /// Setters :
  ////////////////////////////////////////
  SetPrimaryMail({mail}) async {
    primary_mail = mail;
    print('Set Primary mail $mail');
  }

  /////////////////////////////////////////
  /// Getter :
  /////////////////////////////////////////

  GetPrimaryMail() async {
    return primary_mail;
  }
}
