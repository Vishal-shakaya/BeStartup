  // SearchQuery({keywords}) async {
  //   Stream searchStream =
  //       store.collection(getBusinessDetailStoreName).snapshots();

  //   // Loop List of docs which contain startup detail:
  //    searchStream.forEach((event) async {
  //     var startup_length = 1;
  //     for (var doc in event.docs) {
  //       ///////////////////////////////////////////////////
  //       // Filter Startup query :
  //       // 1. check if query start with startup name :
  //       ///////////////////////////////////////////////////

  //       // Conversion query and startup name to lowercase first for comparision :
  //       final startup_name = doc.data()['name'].toString().toLowerCase();
  //       final query = keywords.toString().toLowerCase();

  //       if (startup_name.startsWith(query)) {
  //         final name = doc.data()['name'];
  //         final founder_name = doc.data()['founder_name'];
  //         final startup_id = doc.data()['startup_id'];
  //         final startup_logo = doc.data()['logo'];
  //         // print('startupLength $startup_length');
  //         // print(name);
  //         // print(founder_name);
  //         // print(startup_id);
  //         // print(startup_logo);
  //         startup_length += 1;

  //         await seachHandler.SearchObjectSetter(
  //             startup_id: startup_id,
  //             startup_name: name,
  //             startup_logo: startup_logo,
  //             founder_name: founder_name,
  //             startup_len: startup_length);
  //       }
  //       return await seachHandler.SeachObjctGetter();
  //     }
  //   });
  // }

            // Container(
                      //   // width: context.width*drop_menu_cont_width,
                      //   child: DropdownButton<String>(
                      //       icon: Container(
                      //         margin: EdgeInsets.only(top: 0),
                      //         child: CircleAvatar(
                      //           // backgroundColor: Colors.orange.shade100,
                      //           radius: profile_menu_radiud,
                      //           child: ClipOval(
                      //             child: CachedNetworkImage(
                      //               imageUrl: widget.profile_image,
                      //               fit: BoxFit.cover,
                      //               width: profile_menu_width,
                      //               height: profile_menu_height,
                      //             ),
                      //           ),
                      //         ),
                      //       ),

                      //       items: founderItems.map((item) {
                      //         print('item ${item['text']}');
                      //         var temp_item;

                      //         var item1 = DropdownMenuItem<String>(
                      //           value: '${item['text']}',
                      //           child: Container(
                      //             width: context.width*drop_menu_cont_width,
                      //             child: Row(
                      //               children: [
                      //                 Icon(
                      //                   item['icon'] as IconData,
                      //                   color: input_text_color,
                      //                   size: drop_menu_icon_fontSize,
                      //                 ),
                      //                 SizedBox(
                      //                   width: menu_spacer,
                      //                 ),
                      //                 Text(
                      //                   '${item['text']}',
                      //                   style: TextStyle(
                      //                       color: input_text_color,
                      //                       fontSize: drop_menu_fontSize),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         );

                      //         var item2 = DropdownMenuItem<String>(
                      //             value: '${item['text']}',
                      //             child: Container(
                      //                width: context.width*drop_menu_cont_width,
                      //               child: Column(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceAround,
                      //                 children: [
                      //                   Container(
                      //                     height: menu_divider_height,
                      //                     width: menu_devider_width,
                      //                     decoration: const BoxDecoration(
                      //                       color: Colors.transparent,
                      //                     ),
                      //                   ),
                                        
                      //                   Divider(
                      //                     color: my_theme_icon_color,
                      //                   ),
                                        
                      //                   Spacer(),

                      //                   Container(
                      //                     width: context.width*drop_menu_cont_width,
                      //                     child: Row(
                                            
                      //                       children: [
                      //                         Icon(
                      //                           item['icon'] as IconData,
                      //                           color: input_text_color,
                      //                           size: drop_menu_icon_fontSize,
                      //                         ),
                      //                         SizedBox(
                      //                           width: menu_spacer,
                      //                         ),
                      //                         Text(
                      //                           '${item['text']}',
                      //                           style: TextStyle(
                      //                               color: input_text_color,
                      //                               fontSize: drop_menu_fontSize),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                   SizedBox(
                      //                     height: 5,
                      //                   )
                      //                 ],
                      //               ),
                      //             ));

                      //         if (item['text'] == 'feedback') {
                      //           return item2;
                      //         } else {
                      //           return item1;
                      //         }
                      //       }).toList(),
                      //       onChanged: (v) async {
                      //         if (v == 'profile') {
                      //           await widget
                      //               .changeView(HomePageViews.profileView);
                      //           setState(() {
                      //             is_home_view = false;
                      //             is_save_view = false;
                      //           });
                      //         }

                      //         if (v == 'startup') {
                      //           await CreateStatup();
                      //         }

                      //         if (v == 'settings') {
                      //           await widget
                      //               .changeView(HomePageViews.settingView);
                      //           setState(() {
                      //             is_home_view = false;
                      //             is_save_view = false;
                      //           });
                      //         }

                      //         if (v == 'logout') {
                      //           await LogoutUser();
                      //         }

                      //         if (v == 'feedback') {}
                      //       }),
                      // )

                      
    // var founderItems = [
    //   {'text': 'profile', 'icon': Icons.person},
    //   {'text': 'startup', 'icon': Icons.add_box_outlined},
    //   {'text': 'settings', 'icon': Icons.settings},
    //   {'text': 'logout', 'icon': Icons.logout},
    //   {'text': 'feedback', 'icon': Icons.feedback_outlined},
    // ];