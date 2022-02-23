  
  
import 'package:be_startup/Components/Slides/BusinessProduct/ProductSection.dart';
import 'package:be_startup/Backend/Firebase/FileStorage.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/////////////////////////////////
    // CONFIRM PASSOWRD ALERT :
    // GET CONF_PASS AND STORE IN VAR:
/////////////////////////////////
  SocialMediaLinkDialog({ link,  context , social_medialink_controller,submitLink}) {
     
      Color input_foucs_color = Get.isDarkMode ? tealAccent : darkTeal;
      String prefield_text = '';
      if (LinkType.youtube == link) {
        link = LinkType.youtube;

      }

      if (LinkType.web == link) {
        link = LinkType.web;
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
                                submitLink(link);
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
