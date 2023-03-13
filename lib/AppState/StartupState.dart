import 'package:get_storage/get_storage.dart';

class StartupDetailViewState {
  static var startup_id;
  static var is_admin;
  static var founder_id;
  static var desire_amount;
  static var startup_name;
  static var founder_mail;
  final box = GetStorage();

  SetFounderId({id}) async {
    await box.write('founder_id', id);
    print('fouuder Set $id');
  }

  SetIsUserAdmin({admin}) async {
    is_admin = admin;
    print('admin Set $is_admin');
  }

  SetDesireAmount({amount}) async {
    await box.write('founder_amount', amount);
    print('amount  $amount');
  }

  SetStartupName({name}) async {
    await box.write('founder_startup_name', name);
    print('startup_name  $name');
  }

  SetFounderMail({mail}) async {
    await box.write('founder_primary_mail', mail);
    print('startup_name  $mail');
  }

  /////////////////////////////
  /// Getter :
  /////////////////////////////
  GetStartupId() async {
    return startup_id;
  }

  GetFounderId() async {
    final user = box.read('founder_id');
    return user;
  }

  GetIsUserAdmin() async {
    return is_admin;
  }

  GetDesireAmount() async {
    final amount = box.read('founder_amount');
    return amount;
  }

  GetStartupName() async {
    final name = box.read('founder_startup_name');
    return name; 
  }

  GetFounderMail() async {
    final mail = box.read('founder_primary_mail');
    return founder_mail;
  }
}
