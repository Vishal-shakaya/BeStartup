class StartupDetailViewState {
  static var startup_id;
  static var is_admin;
  static var founder_id;



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



  /////////////////////////////
    /// Getter :
  /////////////////////////////
  GetStartupId({id}) async {
    return startup_id;
  }

  GetFounderId({id}) async {
    return founder_id;
  }

  GetIsUserAdmin({is_admin}) async {
    return is_admin;
  }

  
}
