import 'package:be_startup/Backend/Startup/BusinessDetail/BusinessProductStore.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Utils/utils.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

enum ProductUrlType { youtube, content }

class ProductImageSection extends StatefulWidget {
  String? product_image_url = '';
  String? form_type;
  ProductImageSection({
    this.product_image_url,
    this.form_type,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  Uint8List? image;
  String filename = '';
  String? upload_image_url = '';
  late UploadTask? upload_process;
  bool is_uploading = false;
  final productStore = Get.put(BusinessProductStore(), tag: 'product_store');

  @override
  void initState() {
    super.initState();
    if (widget.form_type == 'update') {
      upload_image_url = widget.product_image_url;
    }
  }

  // Image width and height :
  double image_cont_width = 0.20;
  double image_cont_height = 0.34;

  double img_sec_width = 0.20;
  double img_sec_height = 0.45;

  double url_top_pos = 0.39;
  double url_left_pos = 0.01;

  double product_top_pos = 0.35;
  double product_left_pos = 0.07;

  double upload_btn_top_pod = 0.31;
  double upload_btn_right_pod = 0.15;

  double link_icon_size = 25;
  double upload_btn_icon_size = 30;

  double upload_btn_width = 50;
  double upload_btn_height = 50;

  double take_url_sec_width = 0.30;

  double prod_img_hint_text = 20;

  bool prod_url_sec_visible = false;

  Color active_youtube_icon_color = Colors.red.shade400;
  Color youtube_icon_color = Colors.red.shade200;

  Color active_content_icon_color = Colors.blue.shade400;
  Color content_icon_color = Colors.blue.shade200;

  var product_url_controller = TextEditingController();
  late ProductUrlType url_type;

  SetProductYoutubeUrl() {
    setState(() {
      prod_url_sec_visible = true;
      url_type = ProductUrlType.youtube;
    });
  }

  SetProductContentUrl() {
    setState(() {
      prod_url_sec_visible = true;
      url_type = ProductUrlType.content;
    });
  }

//////////////////////////////////////////////////////
  /// 1. Check if url is null then not update url :
  /// 2. If Success then Update url :
  /// 3. Hide url Input Filed :
//////////////////////////////////////////////////////
  SubmitProductUrl() async {
    var url_val = product_url_controller.text;
    // Null Check :
    if (url_val == '' || url_val == null) {
      return;
    }

    if (url_type == ProductUrlType.youtube) {
      setState(() {
        youtube_icon_color = active_youtube_icon_color;
      });
      final res = await productStore.SetYoutubeLink(url_val);
    }

    if (url_type == ProductUrlType.content) {
      setState(() {
        content_icon_color = active_content_icon_color;
      });
      final res = await productStore.SetContentLink(url_val);
    }

    // Hide input field :
    setState(() {
      prod_url_sec_visible = false;
    });

    // Clear input field :
    product_url_controller.clear();
  }

//////////////////////////////////////////
// UPLOADING IMAGE :
//////////////////////////////////////////
  Future<void> PickImage() async {
    // Pick only one file :
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if rsult null then return :
    if (result == null) return;

    // if file single then gets ist path :
    if (result != null && result.files.isNotEmpty) {
      image = result.files.first.bytes;
      filename = result.files.first.name;

      // IF TRUE THE UPDATE LOGO ELSE SHOW ERROR :
      // 1. Start Loading spinner :
      // 2. If success then stop and show cloud icon :
      // 3. If error then show cloud icon and alert :
      setState(() {
        is_uploading = true;
      });
      var resp = await productStore.UploadProductImage(
          logo: image, filename: filename);

      if (resp['response']) {
        String logo_url = resp['data'];

        // Upldate UI :
        setState(() {
          upload_image_url = logo_url;
          is_uploading = false;
        });
      }

      if (!resp['response']) {
        // show error snakbar :
        Get.snackbar(
          '',
          '',
          margin: EdgeInsets.only(top: 10),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red.shade50,
          titleText: MySnackbarTitle(title: 'Error'),
          messageText: MySnackbarContent(message: 'Something went wrong'),
          maxWidth: context.width * 0.50,
        );

        // Set spinner off :
        setState(() {
          is_uploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////
    if (context.width > 1500) {
      image_cont_width = 0.20;
      image_cont_height = 0.34;

      img_sec_width = 0.20;
      img_sec_height = 0.45;

      url_top_pos = 0.39;
      url_left_pos = 0.01;

      product_top_pos = 0.35;
      product_left_pos = 0.07;

      upload_btn_top_pod = 0.31;
      upload_btn_right_pod = 0.15;

      link_icon_size = 25;
      upload_btn_icon_size = 30;

      upload_btn_width = 50;
      upload_btn_height = 50;

      print('Greator then 1500');
    }

    // PC:
    if (context.width < 1500) {
      print('1500');
    }

    if (context.width < 1450) {
      image_cont_width = 0.25;
      image_cont_height = 0.34;

      img_sec_width = 0.25;
      img_sec_height = 0.45;
      print('1450');
    }

    if (context.width < 1300) {
      image_cont_width = 0.26;
      image_cont_height = 0.30;

      img_sec_width = 0.26;
      img_sec_height = 0.45;

      upload_btn_top_pod = 0.27;
      upload_btn_right_pod = 0.17;

      url_top_pos = 0.35;
      url_left_pos = 0.02;

      product_top_pos = 0.32;
      product_left_pos = 0.08;

      prod_img_hint_text = 18;
      print('1300');
    }

    if (context.width < 1200) {
      image_cont_width = 0.25;
      image_cont_height = 0.27;

      img_sec_width = 0.25;
      img_sec_height = 0.40;

      upload_btn_top_pod = 0.24;
      upload_btn_right_pod = 0.17;

      url_top_pos = 0.32;
      url_left_pos = 0.02;

      product_top_pos = 0.29;
      product_left_pos = 0.08;

      prod_img_hint_text = 16;
      print('1200');
    }

    if (context.width < 1000) {
      image_cont_width = 0.34;
      image_cont_height = 0.27;

      img_sec_width = 0.34;
      img_sec_height = 0.40;

      upload_btn_top_pod = 0.24;
      upload_btn_right_pod = 0.24;

      url_top_pos = 0.32;
      url_left_pos = 0.06;

      product_top_pos = 0.29;
      product_left_pos = 0.12;

      prod_img_hint_text = 15;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      image_cont_width = 0.44;
      image_cont_height = 0.27;

      img_sec_width = 0.44;
      img_sec_height = 0.40;

      upload_btn_top_pod = 0.24;
      upload_btn_right_pod = 0.30;

      url_top_pos = 0.32;
      url_left_pos = 0.08;

      product_top_pos = 0.29;
      product_left_pos = 0.14;

      link_icon_size = 23;
      upload_btn_icon_size = 25;

      upload_btn_width = 40;
      upload_btn_height = 40;

      take_url_sec_width = 0.45;
      prod_img_hint_text = 14;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      image_cont_width = 0.48;
      image_cont_height = 0.24;

      img_sec_width = 0.48;
      img_sec_height = 0.35;

      upload_btn_top_pod = 0.21;
      upload_btn_right_pod = 0.33;

      url_top_pos = 0.28;
      url_left_pos = 0.09;

      product_top_pos = 0.25;
      product_left_pos = 0.15;

      link_icon_size = 23;
      upload_btn_icon_size = 25;

      upload_btn_width = 40;
      upload_btn_height = 40;

      take_url_sec_width = 0.45;
       prod_img_hint_text = 14;
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      image_cont_width = 0.70;
      image_cont_height = 0.24;

      img_sec_width = 0.70;
      img_sec_height = 0.35;

      upload_btn_top_pod = 0.21;
      upload_btn_right_pod = 0.38;

      url_top_pos = 0.28;
      url_left_pos = 0.09;

      product_top_pos = 0.25;
      product_left_pos = 0.15;

      link_icon_size = 18;
      upload_btn_icon_size = 18;

      upload_btn_width = 30;
      upload_btn_height = 30;

      take_url_sec_width = 0.60;

      prod_img_hint_text = 12;
      print('480');
    }

    // IMAGE BLOCK:
    return Container(
      width: context.width * img_sec_width,
      height: context.height * img_sec_height,
      child: Stack(
        children: [
          upload_image_url == ''
              ? ImagePreviewContainer(context)
              : // IMAGE BLOCK :
              ImageContainer(context, upload_image_url),

          // Upload Button :
          UploadButton(context),

          ProductLinks(context),

          // Take Content Link :
          UrlSection(context)
        ],
      ),
    );
  }

  Visibility UrlSection(BuildContext context) {
    return Visibility(
      visible: prod_url_sec_visible,
      child: Positioned(
        top: context.height * url_top_pos,
        left: context.width * url_left_pos,
        child: Container(
          width: context.width * take_url_sec_width,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: product_url_controller,
                  decoration: InputDecoration(hintText: 'paste url'),
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 25, left: 15),
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                        onPressed: () {
                          SubmitProductUrl();
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.blue.shade300,
                          size: link_icon_size,
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container ProductLinks(BuildContext context) {
    return Container(
        child: Positioned(
      top: context.height * product_top_pos,
      left: context.width * product_left_pos,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              SetProductYoutubeUrl();
            },
            child: Tooltip(
              message: 'Add youtube video link',
              child: Icon(
                Icons.video_library_rounded,
                color: youtube_icon_color,
                size: link_icon_size,
              ),
            ),
          ),
          // Spacing
          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              SetProductContentUrl();
            },
            child: Tooltip(
              message: 'Add content supportive Link',
              child: Icon(
                Icons.link_outlined,
                color: content_icon_color,
                size: link_icon_size,
              ),
            ),
          )
        ],
      ),
    ));
  }

  Positioned UploadButton(BuildContext context) {
    return Positioned(
      top: context.height * upload_btn_top_pod,
      left: context.width * upload_btn_right_pod,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          PickImage();
        },
        child: Card(
          color: Colors.orange,
          shadowColor: Colors.orangeAccent.shade400,
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Container(
            padding: EdgeInsets.all(5),
            width: upload_btn_width,
            height: upload_btn_height,
            child: is_uploading
                ? Container(
                    padding: EdgeInsets.all(5),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4,
                    ),
                  )
                : Icon(Icons.cloud_upload,
                    color: Colors.white, size: upload_btn_icon_size),
          ),
        ),
      ),
    );
  }

  Container ImageContainer(BuildContext context, final_image) {
    return Container(
        width: context.width * image_cont_width,
        height: context.height * image_cont_height,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20)),
            border: Border.all(width: 2, color: Colors.grey)),
        child: ClipRRect(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          ),
          child: Image.network(final_image,
              width: context.width * image_cont_width,
              height: context.height * image_cont_height,
              fit: BoxFit.cover),
        ));
  }

  Container ImagePreviewContainer(BuildContext context) {
    return Container(
        width: context.width * image_cont_width,
        height: context.height * image_cont_height,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            border: Border.all(width: 2, color: Colors.grey)),
        child: Container(
          alignment: Alignment.center,
          child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline3, children: [
              TextSpan(
                  text: product_image_subhead,
                  style: TextStyle(
                      color: Colors.blueGrey.shade200,
                      fontWeight: FontWeight.bold,
                      fontSize: prod_img_hint_text))
            ]),
          ),
        ));
  }
}
