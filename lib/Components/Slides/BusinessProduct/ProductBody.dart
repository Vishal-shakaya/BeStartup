import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

enum LinkType {
  youtube,
  web,
}

class ProductBody extends StatefulWidget {
  const ProductBody({Key? key}) : super(key: key);

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  final formKey = GlobalKey<FormBuilderState>();

  Uint8List? image;
  String filename = '';
  String upload_image_url = '';
  late UploadTask? upload_process;

  double prod_cont_width = 0.80;
  double prod_cont_height = 0.90;

  double image_cont_width = 0.5;
  double image_cont_height = 0.38;

  double image_sec_height = 0.32;
  double image_sec_width = 0.50;

  double upload_btn_top = 0.32;
  double upload_btn_left = 0.16;

  double upload_btn_width = 40;
  double upload_btn_height = 40;

  double heading_text_width = 200;

  Color suffix_icon_color = Colors.blueGrey.shade300;
  Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
  int maxlines = 10;

  TextEditingController social_medialink_controller = TextEditingController();

  String youtube_link = '';
  String web_link = '';
  bool selected_tag_prod = false;

  ToogleProduct() {
    setState(() {
      selected_tag_prod = !selected_tag_prod;
    });
  }
  ///////////////////////////////////////
  /// SUBMIT PRODUCT FORM :
  /// ////////////////////////////////////

  SubmitProductForm() {
    if (formKey.currentState!.validate()) {
      final heading = formKey.currentState!.value['heading'];
      final description = formKey.currentState!.value['description'];
    }
  }

  /// RESET FORM :
  ResetProductForm() {
    formKey.currentState!.reset();
  }

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

  // CALL FUNCTION TO UPLOAD IMAGE :
  // THEN CALL UPLOD IMAGE FOR UPLOAD IMAGE IN BACKGROUND :
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

////////////////////////////////////////////////////
  /// SOCAIL MEDIA LINK SUBMIT FORM :
  ///  1. GET YOUTUBE LINK :
  ///  2. OR OTHER WEB LINK :
  ///  VALIDATE LINK : IF NOT NULL :
  ///  STORE IN VAR THEN  BACKEND :
  ///  CLEAR TEXT FIELD AFTER SUCCESSFUL SUBMISSION:
  /// //////////////////////////////////////////////////
  SubmitLink(LinkType link) {
    final text = social_medialink_controller.text;
    // print(text);
    // if (text == '') {
    //   CoolAlert.show(
    //       context: context,
    //       width: 200,
    //       title: 'Enter Valid Link',
    //       type: CoolAlertType.warning,
    //       widget: Text(
    //         'emply field not allow',
    //         style: TextStyle(
    //             color: Get.isDarkMode ? Colors.white : Colors.blueGrey.shade900,
    //             fontWeight: FontWeight.bold),
    //       ));
    //   return;
    // }

    // YOUTUBE SECTION:
    if (link == LinkType.youtube) {
      setState(() {
        youtube_link = text;
      });
      Navigator.of(context).pop();
      FocusManager.instance.primaryFocus?.unfocus();
      social_medialink_controller.clear();
    }

    // WEB LINK :
    if (link == LinkType.web) {
      setState(() {
        web_link = text;
      });
      Navigator.of(context).pop();
      FocusManager.instance.primaryFocus?.unfocus();
      social_medialink_controller.clear();
    }
  }

  RemoveProduct() {
    print('delte product');
  }

// DISPOSE ;
// 1 SOCIAL MEDIA TEXT CONTROLLER :
  @override
  void dispose() {
    // TODO: implement dispose
    social_medialink_controller.clear();
    social_medialink_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /////////////////////////////////
    // CONFIRM PASSOWRD ALERT :
    // GET CONF_PASS AND STORE IN VAR:
    /////////////////////////////////
    SocialMediaLinkDialog(LinkType link) {
      String prefield_text = '';
      if (LinkType.youtube == link) {
        link = LinkType.youtube;
        prefield_text = youtube_link; 
      }

      if (LinkType.web == link) {
        link = LinkType.web;
        prefield_text = web_link; 
      }

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => FractionallySizedBox(
                widthFactor: 0.30,
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  title: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                                link == LinkType.youtube
                                    ? 'Youtube Video Url'
                                    : 'Refernce  Url',
                                style: Get.textTheme.headline2)),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Icon(Icons.cancel_outlined,
                              color: Colors.blueGrey.shade300, size: 20))
                    ],
                  ),
                  content: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    width: context.width * 0.99,
                    height: context.height * 0.27,
                    // alignment: Alignment.center,

                    child: Column(
                      children: [
                        TextField(
                          controller: social_medialink_controller,
                          decoration: InputDecoration(
                            // errorText: 'Enter valid link',
                            prefixIcon: Icon(
                              Icons.paste,
                              color: Colors.orange.shade300,
                              size: 16,
                            ),
                            hintText: 'paste url',
                            contentPadding: EdgeInsets.all(16),
                            hintStyle: TextStyle(
                              fontSize: 15,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.teal.shade300)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    width: 2, color: input_foucs_color)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),

                        // CONFIRM BUTTON :
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.only(top: 30),
                          child: TextButton.icon(
                              onPressed: () async {
                                SubmitLink(link);
                              },
                              icon: Icon(Icons.check,
                                  size: 17, color: Colors.blue.shade300),
                              label: Text(
                                'confirm',
                                style: TextStyle(
                                    color: Colors.blue.shade400,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ));
    }

    return Container(
      width: context.width * prod_cont_width,
      height: context.height * prod_cont_height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(flex: 1, child: Container()),
              Container(
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primary_light)),
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      label: Text('Add')))
            ],
          ),

          ////////////////////////////////////////////////
          // PRODUCT SECTION;
          ////////////////////////////////////////////////
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /////////////////////////////////////
                // IMAGE SECTION :
                // ROW VIEW FOR IMAGE PREVIEW :
                // SHOW UPLOAD BUTTON FOR UPLOAD IMAGE :
                /////////////////////////////////////
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        height: context.height * image_cont_height,
                        width: context.width * image_cont_width,
                        child: Stack(
                          children: [
                            upload_image_url == ''
                                ? Container(
                                    height: context.height * image_sec_height,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 29),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                left: Radius.circular(20),
                                                right: Radius.circular(20)),
                                        border: Border.all(
                                            width: 2, color: Colors.black54)),
                                    child: AutoSizeText.rich(TextSpan(
                                        style: Get.textTheme.headline3,
                                        children: [
                                          TextSpan(
                                              text: product_image_subhead,
                                              style: TextStyle(
                                                  color:
                                                      Colors.blueGrey.shade200,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15))
                                        ])),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(2),
                                    height: context.height * image_sec_height,
                                    margin: EdgeInsets.only(top: 29),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20),
                                            right: Radius.circular(20)),
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade200)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(19),
                                        right: Radius.circular(19),
                                      ),
                                      child: Image.network(upload_image_url,
                                          width:
                                              context.width * image_cont_width,
                                          height: context.height *
                                              image_cont_height,
                                          fit: BoxFit.cover),
                                    )),
                            Positioned(
                              top: context.height * upload_btn_top,
                              left: context.width * upload_btn_left,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  PickImage();
                                },
                                child: Card(
                                  color: Colors.orange,
                                  shadowColor: Colors.orangeAccent.shade400,
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width: upload_btn_width,
                                    height: upload_btn_height,
                                    child: Icon(Icons.cloud_upload,
                                        color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      /////////////////////////////////////
                      /// YOUTUBE BUTTON TO UPLAOD LINK :
                      /////////////////////////////////////

                      Container(
                        // margin: EdgeInsets.only(left: 20, ),
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                SocialMediaLinkDialog(LinkType.youtube);
                              },
                              child: Icon(
                                Icons.play_circle_fill_outlined,
                                color: youtube_link == ''
                                    ? Colors.red.shade200
                                    : Colors.red.shade400,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                SocialMediaLinkDialog(LinkType.web);
                              },
                              child: Icon(
                                Icons.link_outlined,
                                color: web_link == ''
                                    ? Colors.blue.shade200
                                    : Colors.blue.shade400,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                ////////////////////////////////////////////////
                // PRODUCT TITLE AND DESCRIPTION SECTION :
                // 1 HEADING :
                // 2 DESCRIPTION :
                ////////////////////////////////////////////////

                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: FormBuilder(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  textAlign: TextAlign.center,
                                  name: 'prod_heading',
                                  style: Get.textTheme.headline2,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.minLength(context, 3,
                                        errorText: 'At least 3 char allow')
                                  ]),
                                  decoration: InputDecoration(
                                    hintText: 'Representative Heading',
                                    contentPadding: EdgeInsets.all(16),
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade300),

                                    suffix: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          color: suffix_icon_color,
                                        ),
                                      ),
                                    ),

                                    // focusColor:Colors.pink,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: primary_light)),
                                  ),
                                ),

                                // PROD DESCRIPTION BOX :
                                SizedBox(
                                  height: 25,
                                ),

                                Container(
                                  width: context.width * 0.8,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: FormBuilderTextField(
                                          name: 'prod_desc',
                                          style: GoogleFonts.robotoSlab(
                                            fontSize: 16,
                                          ),
                                          maxLength: 2000,
                                          scrollPadding: EdgeInsets.all(10),
                                          maxLines: maxlines,
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.minLength(
                                                context, 40,
                                                errorText:
                                                    'At least 40 char allow')
                                          ]),
                                          decoration: InputDecoration(
                                              helperText: 'min allow 200 ',
                                              hintText: "Product revision",
                                              hintStyle: TextStyle(
                                                color: Colors.blueGrey.shade200,
                                              ),
                                              fillColor: Colors.grey[100],
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.all(20),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                      width: 1.5,
                                                      color: Colors
                                                          .blueGrey.shade200)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: primary_light)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                        ),
                                      ),

                                      /////////////////////////////////
                                      /// TAG BUTTON :
                                      /// 1 PRODCUT :
                                      /// 2 SERVIECE:
                                      /////////////////////////////////
                                      Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: context.height * 0.12),
                                            child: InkWell(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              onTap: () {
                                                RemoveProduct();
                                              },
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                elevation: 10,
                                                shadowColor: Colors.blueGrey,
                                                child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        Colors.red.shade200,
                                                    child: Icon(Icons.close,
                                                        // size:15,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: context.height * 0.01),
                                              alignment: Alignment.bottomLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    onTap: () {
                                                      ToogleProduct();
                                                    },
                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      elevation: 10,
                                                      shadowColor:
                                                          Colors.blueGrey,
                                                      child: CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                            Colors.green,
                                                        child: selected_tag_prod
                                                            ? Icon(
                                                                Icons.check,
                                                                size: 15,
                                                                color: Colors
                                                                    .white,
                                                              )
                                                            : Text('P',
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    // fontSize: 15,
                                                                    fontWeight: FontWeight.bold)),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    onTap: () {
                                                      ToogleProduct();
                                                    },
                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      elevation: 10,
                                                      shadowColor:
                                                          Colors.blueGrey,
                                                      child: CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor:
                                                              Colors.blue
                                                                  .shade300,
                                                          child: selected_tag_prod
                                                              ? Text('S',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))
                                                              : Icon(
                                                                  Icons.check,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .white)),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),

                // Expanded(
                //   flex: 1,
                //   child: Container())
              ],
            ),
          )
        ],
      ),
    );
  }
}
