import 'package:get/get.dart';

enum UserType{
  founder, 
  investor, 
  none, 
}

enum ProductType {
  service,
  product,
}

enum ProductUrlType { youtube, content }

enum HomePageViews {
  storyView,
  safeStory,
  settingView,
  profileView,
  exploreView, 
}

enum ReautheticateTask{
  updateEmail, 
  deleteProfile 
}

enum NumberOperation{
  update, 
  verify , 
}

enum InvestorFormType {
  create , 
  edit , 
}

enum IsUserPlanBuyedType {
  preplan , 
  newplan, 
}

enum MySnackbarType{
  error, 
  success,
  info ,  
}

enum FounderStartupMenu {
  intrested, 
  my_startup, 
}