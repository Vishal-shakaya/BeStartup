
import 'dart:typed_data';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart' as a;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:crop_your_image/crop_your_image.dart';
class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormBuilderState>();
  String login_text = 'Login';
  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;
  final controller = CropController();
  /////////////////////////////////////////
  // PICKED IMAGE AND STORE IN  FILE :
  /////////////////////////////////////////

  Future UploadImage() async {
    if (image == null) return;

    // UPLOAD FILE LOCAION IN FIREBASE : 
    final destination = 'user_profile/profile_image/$filename';
    upload_process = FileStorage.UploadFileBytes(destination, image!);
    // ERROR ACCURE 
    if (upload_process == null) return;

    final snapshot = await upload_process!.whenComplete(() {
      print('PROFILE UPLOADED');
    });

    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      upload_image_url = urlDownload;
    });
  }

  Future<void> PickImage() async {
    // Pick only one file :
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if rsult null then return :
    if (result == null) return;

    // if file single then gets ist path :
    if (result != null && result.files.isNotEmpty) {
      image = result.files.first.bytes;
      filename = result.files.first.name;
      await UploadImage();
    }
  }

  // Change Theme :
  final _formKey = GlobalKey<FormBuilderState>();
  bool is_password_visible = true;
  Color input_text_color =
      Get.isDarkMode ? Colors.grey.shade100 : Colors.black87;
  Color input_foucs_color =
      Get.isDarkMode ? Colors.tealAccent : Colors.teal.shade400;
  Color input_label_color =
      Get.isDarkMode ? Colors.blueGrey.shade100 : Colors.blueGrey.shade900;

  // SUBMIT SIGNUP FORM :
  SubmitSignupForm() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      String email = _formKey.currentState!.value['email'];
      String password = _formKey.currentState!.value['password'];
      _formKey.currentState!.reset();
    } else {
      print('error found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: FractionallySizedBox(
                // widthFactor: 0.20,
                // heightFactor: 0.30,
                child: Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Signup Now', style: Get.textTheme.headline3),
                        Container(
                            margin: EdgeInsets.only(top: context.height * 0.02),
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Card(
                                  shadowColor: light_color_type3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(85.0),
                                  ),
                                  child: upload_image_url!=''? 
                                  CircleAvatar(
                                      radius: 85,
                                      backgroundColor: Colors.blueGrey[100],
                                      foregroundImage: NetworkImage(upload_image_url),
                                    ):
                                  CircleAvatar(
                                      radius: 85,
                                      backgroundColor: Colors.blueGrey[100],
                                      child: Icon(
                                        Icons.person,
                                          size: 70,
                                          color: light_color_type3)
                                    )

                                ),

                                //////////////////////////////
                                // UPLOAD CAMERA ICON:
                                ////////////////////////////////
                                Positioned(
                                    top: 129,
                                    left: 129,
                                    child: Card(
                                      shadowColor: primary_light,
                                      // elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade200,
                                        radius: 18,
                                        child: IconButton(
                                            onPressed: () {
                                              PickImage();
                                            },
                                            icon: Icon(Icons.camera_alt_rounded,
                                                size: 19,
                                                color: primary_light)),
                                      ),
                                    )),
                              ],
                            )),
                        Container(
                            width: 400,
                            margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                FormBuilder(
                                    key: _formKey,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: Column(children: [
                                      ////////////////////////////
                                      // EMAIL  SECTION
                                      ///////////////////////////

                                      // EMAIL HEADER :
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text('Email addresss',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: input_label_color)),
                                      ),

                                      // EMAIL INPUT FILED :
                                      FormBuilderTextField(
                                        name: 'email',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: Get.isDarkMode
                                                ? FontWeight.w400
                                                : FontWeight.w600,
                                            color: input_text_color),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.email(context,
                                              errorText: 'enter valid email')
                                        ]),
                                        decoration: InputDecoration(
                                            hintText: 'enter mail ',
                                            hintStyle: TextStyle(
                                              fontSize: 15,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.email_rounded,
                                              color: Colors.orange.shade300,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color:
                                                        Colors.teal.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: input_foucs_color)),
                                            // errorText: 'invalid email address',
                                            // constraints: BoxConstraints(),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),

                                      ////////////////////////////
                                      // PASSWORD SECTION
                                      ///////////////////////////
                                      ///
                                      // PASSWORD LABEL:
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text('Password',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: input_label_color)),
                                      ),

                                      // PASSWORD INPUT FILED :
                                      FormBuilderTextField(
                                        name: 'password',
                                        obscureText: is_password_visible,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: Get.isDarkMode
                                                ? FontWeight.w400
                                                : FontWeight.w600,
                                            color: input_text_color),
                                        keyboardType:
                                            TextInputType.emailAddress,

                                        // Validate password
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.minLength(
                                              context, 8,
                                              errorText: 'invalid password')
                                        ]),

                                        decoration: InputDecoration(
                                            hintText: 'enter password',
                                            hintStyle: TextStyle(
                                              fontSize: 15,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.lock_rounded,
                                              color: Colors.orange.shade300,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color:
                                                        Colors.teal.shade300)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: input_foucs_color)),
                                            // errorText: 'invalid email address',
                                            // constraints: BoxConstraints(),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ])),

                                /////////////////////////
                                /// LOGIN BUTTON :
                                /// /////////////////////
                                Container(
                                  width: 270,
                                  height: 42,
                                  margin: EdgeInsets.only(top: 40),
                                  child: a.GradientElevatedButton(
                                      gradient: g1,
                                      onPressed: () async {
                                        await SubmitSignupForm();
                                      },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        // side: BorderSide(color: Colors.orange)
                                      ))),
                                      child: Text('Signup',
                                          style: TextStyle(
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ))),
                                ),
                              ],
                            ))

                            // Crop widget: 
                      ],
            )
              )
                )
                 )
                   );
  }
}


