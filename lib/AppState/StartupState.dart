class StartupDetailViewState {
  static var startup_id;
  static var is_admin;
  static var founder_id;
  static var desire_amount;
  static var startup_name;
  static var founder_mail;



///////////////////////////////
/// Setter :
///////////////////////////////
  SetStartupId({id}) async {
    startup_id = id;
    print('Set $startup_id');
  }

  SetFounderId({id}) async {
    founder_id = id;
    print('Set $founder_id');
  }

  SetIsUserAdmin({admin}) async {
    is_admin = admin;
    print('Set $is_admin');
  }


  SetDesireAmount({amount}) async {
    desire_amount = amount;
    print('Set $amount');
  }

  SetStartupName({name}) async {
    startup_name = name;
    print('Set $startup_name');
  }

  SetFounderMail({mail}) async {
    founder_mail = mail;
    print('Set $mail');
  }



  /////////////////////////////
    /// Getter :
  /////////////////////////////
  GetStartupId() async {
    return startup_id;
  }

  GetFounderId() async {
    return founder_id;
  }

  GetIsUserAdmin() async {
    return is_admin;
  }

  GetDesireAmount() async {
    return desire_amount;
  }

  GetStartupName() async {
    return startup_name;
  }


  GetFounderMail() async {
    return founder_mail;
  }

  
}
