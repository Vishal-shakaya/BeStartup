import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Users/Founder/FounderConnector.dart';
import 'package:be_startup/Backend/Startup/connector/FetchStartupData.dart';
import 'package:be_startup/Components/StartupView/StartupHeaderText.dart';
import 'package:be_startup/Components/StartupView/TeamPage/MemberBlock.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  var startupConnect =
      Get.put(StartupViewConnector(), tag: 'startup_view_first_connector');
  var startupviewConnector = Get.put(StartupViewConnector(), tag: 'startup_view_connector');
  var founderConnector =
  Get.put(FounderConnector(), tag: 'startup_view_first_connector');
  
  var team_member;
  double page_width = 0.80;


  // REDIRECT TO CREATE MEMEBER PAGE :
  EditMember() {
    Get.toNamed(create_business_team, parameters: {'type': 'update'});
  }


  //////////////////////////////////////////
  // GET REQUIREMTNS : 
  //////////////////////////////////////////
  GetLocalStorageData() async {
    try {
      final data = await startupviewConnector.FetchBusinessTeamMember();
      team_member = data['data']['members'];
      return team_member;
    } catch (e) {
      return team_member;
    }
  }


  @override
  Widget build(BuildContext context) {

  //////////////////////////////////////////
  // SET REQUIREMTNS : 
  //////////////////////////////////////////
    return FutureBuilder(
        future: GetLocalStorageData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Shimmer.fromColors(
              baseColor: shimmer_base_color,
              highlightColor: shimmer_highlight_color,
              child: snapshot.data == null
                  ? Text('Loading Members', style: Get.textTheme.headline2)
                  : MainMethod(
                      context: context,
                      data: snapshot.data),
            ));
          }
          if (snapshot.hasError) return ErrorPage();

          if (snapshot.hasData) {
            return MainMethod(
                context: context,
                data: snapshot.data);
          }
          return MainMethod(
              context: context,
              data: snapshot.data);
        });

    // TEAM MEMBER   SECTION :
  }

  Container MainMethod({context, data}) {
    return Container(
        width: MediaQuery.of(context).size.width * page_width,
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              // Heading :
              StartupHeaderText(
                title: 'Founder',
                font_size: 32,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // Member List Section :
              Column(
                children: [
                  // FOUNDER SECTION :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 1,
                        shadowColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.height * 0.34,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                            // border: Border.all(color: border_color),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: 10),
                          child: Container(
                            padding: EdgeInsets.all(12),

                            // MEMBER DETAIL SECTION :
                            child: Column(
                              children: [
                                // Profile Image
                                ProfileImage(),

                                // SPACING:
                                SizedBox(
                                  height: 15,
                                ),

                                // POSITION:
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    children: [
                                      MemPosition(),
                                      // MEMBER NAME :
                                      MemName(),
                                      // CONTACT EMAIL ADDRESS :
                                      MemContact(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  // SPACING :
                  SizedBox(height: MediaQuery.of(context).size.height * 0.10),

                  StartupHeaderText(
                    title: 'Members',
                    font_size: 32,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  // EDIT TEAM MEMBER :
                  // REDIRECT TO CREATE TEAME PAGE :
                  EditButton(context, EditMember),
                  Card(
                    elevation: 1,
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: MediaQuery.of(context).size.height * 0.70,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        // border: Border.all(color: border_color),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return MemberBlock(member: data[index]);
                        },
                      ),
                    ),
                  ),

                  // // Spacing :
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  // // Headign :
                  // StartupHeaderText(
                  //   title: 'Members',
                  //   font_size: 32,
                  // ),
                  // // ALL MEMBER LIST
                  // AllMembers()
                ],
              )
            ],
          ),
        )));
  }

  Container EditButton(BuildContext context, Function fun) {
    return Container(
        width: context.width * 0.48,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
        child: Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: border_color)),
          child: TextButton.icon(
              onPressed: () {
                fun();
              },
              icon: Icon(
                Icons.edit,
                size: 15,
              ),
              label: Text('Edit')),
        ));
  }

  Container MemContact() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.mail_outline_outlined,
            color: Colors.orange.shade300,
            size: 16,
          ),
        ),
        AutoSizeText.rich(TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              // text: widget.member!['member_mail'],
              text: 'vishalsakaya@gmail.com',
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blue,
                  fontSize: 11))
        ])),
      ],
    ));
  }

  Container MemName() {
    return Container(
        alignment: Alignment.center,
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline5, children: [
          TextSpan(
              text: 'vishal shakaya',
              style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 13))
        ])));
  }

  Container MemPosition() {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: AutoSizeText.rich(
            TextSpan(style: Get.textTheme.headline2, children: [
          TextSpan(
              // text: widget.member!['position'],
              text: 'CEO',
              style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 15))
        ])));
  }

  Container ProfileImage() {
    return Container(
        child: CircleAvatar(
      radius: 70,
      backgroundColor: Colors.blueGrey[100],
      // foregroundImage: NetworkImage(widget.member!['image']),
      foregroundImage: NetworkImage(temp_image),
    ));
  }
}
