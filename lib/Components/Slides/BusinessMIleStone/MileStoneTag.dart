import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_startup/Backend/Startup/MileStoneStore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MileStoneTag extends StatefulWidget {
  Map<String, dynamic>? milestone;
  MileStoneTag({this.milestone, Key? key}) : super(key: key);

  @override
  State<MileStoneTag> createState() => _MileStoneTagState();
}

class _MileStoneTagState extends State<MileStoneTag> {
  Color mil_default_text_color = Colors.black;
  Color mil_activate_text_color = Colors.teal.shade300;
  Color mil_deactivate_text_color = Colors.black;

  final mileStore = Get.put(MileStoneStore(), tag: 'first_mile');

  /////////////////////////////////////////////
  // Show Mile Stone info in dialog box :
  /////////////////////////////////////////////
  MileStoneInfo() {
    try {
      print('Show Mile Stone');
    } catch (e) {
      print(' *** ERROR WHILE Show MILE STONE ***');
    }
  }

  /////////////////////////////////////////////
  // Edit Mile Stone :
  /////////////////////////////////////////////
  EditMileStone() {
    try {
      print('Show Edit');
    } catch (e) {
      print(' *** ERROR WHILE Edit MILE STONE ***');
    }
  }

  /////////////////////////////////////////////
  // Delete Mile Stone
  /////////////////////////////////////////////
  DeleteMileStone(id) {
    final res = mileStore.DeleteMileStone(id);
    if (res['response']) { print('successs');}
    if (!res['response']) { print('error'); }
  }

  @override
  Widget build(BuildContext context) { 
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.symmetric(vertical: 10),

      // Decoration:
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          )),
      child: MouseRegion(
        onHover: (_) {
          setState(() {
            mil_default_text_color = mil_activate_text_color;
          });
        },
        onExit: (_) {
          setState(() {
            mil_default_text_color = mil_deactivate_text_color;
          });
        },
        child: ListTile(
          key: UniqueKey(),
          onTap: () {
            MileStoneInfo();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          )),
          selectedColor: Colors.blue.shade50,
          hoverColor: Colors.blue.shade50,
          focusColor: Colors.teal.shade50,
          selectedTileColor: Colors.teal.shade50,

          // Tile Style :
          style: ListTileStyle.drawer,

          // Heading text:
          title: Container(
              padding: EdgeInsets.all(10),
              child: AutoSizeText('${widget.milestone!['title']}',
                  style: GoogleFonts.robotoSlab(
                    color: mil_default_text_color,
                  ))),

          // Edit and Delte Button :
          trailing: Wrap(
            children: [
              // EDIT ICION :
              InkWell(
                onTap: () {
                  EditMileStone();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue.shade300,
                    size: 20,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  DeleteMileStone(widget.milestone!['id']);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red.shade300,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
