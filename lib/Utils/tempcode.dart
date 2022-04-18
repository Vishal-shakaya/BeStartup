// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:be_startup/Utils/Colors.dart';
// import 'package:be_startup/Utils/Messages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// class InvestorSection extends StatelessWidget {
//   const InvestorSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//   double mem_desc_block_width = 0.15;
//   double mem_desc_block_height = 0.10;

//     return Container(
//        height: context.height* 0.30,
//        width: context.width*100, 
//        color: Colors.orange.shade300,

//        child:Container(
//         alignment: Alignment.center,
//         width: context.width*70, 
//          child: SingleChildScrollView(
//            scrollDirection: Axis.horizontal,
//            child: Container(
//              child: Row(
//                children: [

//                 // Investor Block :   
//                  Card(
//                    elevation: 8,
//                    color: Colors.transparent,
//                    shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)), 
//                    ),
//                    child: Container(
//                      width:context.width*0.30, 
//                      height:context.height*0.21, 
//                      padding: EdgeInsets.all(10),
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(10)), 
//                      ),
//                      child: Wrap(
//                        alignment: WrapAlignment.spaceEvenly,
//                        children: [
//                          // PROFILE IMAGE : 
//                          Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: [
//                              ProfileImage(),
                            
//                             // POSITION:
//                               SizedBox(
//                                 width:200, 
//                                 child: Column(
//                                   children: [
//                                   SizedBox(
//                                       height: 15,
//                                     ),
//                                     MemName(),
//                                     // CONTACT EMAIL ADDRESS :
//                                     MemContact(),
//                                   ],
//                                 ),
//                               ),
//                           ],
//                          ),
                 
//                       // DESCRIPTION: 
//                       MemDescription(context, mem_desc_block_width, mem_desc_block_height), 
                          
//                        ],
//                      ),
//                    ),
//                  ) ,

//                ],
//              ),
//            )),
//        ),
//     );
    
//   } 
  
  
//    Card MemDescription(
//      BuildContext context,
//      mem_desc_block_width,
//      mem_desc_block_height) {
//     return Card(
//       shadowColor: Colors.red,
//       elevation: 5,
//       child: Column( 
//         children: [
//           Container(
//             padding: EdgeInsets.all(4),
//             child: RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(children: [
//                     // Heading Texct :
//                     TextSpan(
//                       text: ' 😎 Managing Director',
//                       style: GoogleFonts.robotoSlab(
//                         textStyle: TextStyle(),
//                         color: light_color_type2,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         height: 1.70,
//                       ),
//                     ),
//                   ])),
//           ),

//           Container(
//             padding: EdgeInsets.all(15),
//             width: context.width * 0.15,
//             height: context.height * 0.12,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.horizontal(
//                   left: Radius.circular(20),
//                   right: Radius.circular(20),
//                 ),
//                 ),
//             child: Container(
//               padding: EdgeInsets.only(bottom: 15),
//               child: RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(children: [
//                     // Heading Texct :
//                     TextSpan(
//                       text: long_string,
//                       style: GoogleFonts.openSans(
//                         textStyle: TextStyle(),
//                         color: light_color_type3,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         height: 1.70,
//                       ),
//                     ),
//                   ]),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 4,
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//     Container ProfileImage() {
//     return Container(
//         child: CircleAvatar(
//       radius: 60,
//       backgroundColor: Colors.blueGrey[100],
//       foregroundImage: NetworkImage(profile_image),
//     ));
//   }

//     Container MemName() {
//     return Container(
//         child: AutoSizeText.rich(
//             TextSpan(style: Get.textTheme.headline5, children: [
//       TextSpan(
//           text: 'vishal shakaya',
//           style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 16))
//     ])));
//   }

//   Container MemPosition() {
//     return Container(
//         margin: EdgeInsets.only(bottom: 10),
//         child: AutoSizeText.rich(
//             TextSpan(style: Get.textTheme.headline2, children: [
//           TextSpan(
//               text: 'Founder',
//               style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 15))
//         ])));
//   }

//     Container MemContact() {
//     return Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Icon(
//             Icons.mail_outline_outlined,
//             color: Colors.orange.shade800,
//             size: 16,
//           ),
//         ),
//         AutoSizeText.rich(
//           TextSpan(
//             style: Get.textTheme.headline5, 
//             children: [
//           TextSpan(
//               text: 'shakayavishal007@gmail.com',
//               style: TextStyle(
//                 overflow: TextOverflow.ellipsis,
//                 color: Colors.blueGrey.shade700, fontSize: 11))
//         ])),
//       ],
//     ));
//   }

// }