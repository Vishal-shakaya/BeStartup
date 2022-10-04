import 'package:be_startup/Components/HomeView/SearhBar/StartupResultTIle.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

// tITLE TO SHOW SEARCH RESULTS
class BusinessSearchBar extends StatefulWidget {
  BusinessSearchBar({Key? key}) : super(key: key);
  @override
  State<BusinessSearchBar> createState() => _BusinessSearchBarState();
}

class _BusinessSearchBarState extends State<BusinessSearchBar> {
  String? title;
  FirebaseFirestore store = FirebaseFirestore.instance;
  var searchInputController = TextEditingController();

  var searchQuery;

  String queryKeywords = '';
  bool? is_searching = false;
  bool? is_searching_process = false;

  double searchResultContainerHeight = 0.35;

  double search_bar_left_pos = 0.33;

  double search_cont_top_margin = 0.02;

  double search_box_width = 0.20;

  double search_bar_height = 50;

  double search_box_top_margin = 5;

  double search_text_fontSize = 16;

  double search_iconSize = 22;

  double search_bar_content_padding = 10;

  double search_bar_top_margin = 0;

  ////////////////////////////////////////////////////////////////////
  /// It takes a string as input and returns
  /// a stream of documents from firestore
  ///
  /// 1. If Serach keyword containts @ then Search with [Founder Name]
  /// 2. else serch with [Startup Name]
  /// Returns:
  ///   A stream of QuerySnapshot<Map<String, dynamic>>
  ////////////////////////////////////////////////////////////////////

  SearchingAlgo() {
    Stream<QuerySnapshot<Map<String, dynamic>>>? mainStream;
    // Stream<QuerySnapshot<Map<String, dynamic>>> startupStream;
    // Stream<QuerySnapshot<Map<String, dynamic>>> founderStream;
    // List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList = [];

    if (queryKeywords.contains('@')) {
      var new_key = queryKeywords.replaceAll('@', '');
      new_key = new_key.trim();
      mainStream = store
          .collection(getBusinessDetailStoreName)
          .where('founder_searching_index', arrayContains: new_key)
          .snapshots();
    } else {
      mainStream = store
          .collection(getBusinessDetailStoreName)
          .where('startup_searching_index', arrayContains: queryKeywords)
          .snapshots();
    }

    // Trying to merge two string results : Not wroking:
    // var merge = MergeStream([startupStream, founderStream]);
    // merge.forEach((element) {
    //   dataList.addAll(element.docs);
    // });

    // dataList.forEach((element) {
    //   print(element);
    // });

    return mainStream;
  }

  @override
  Widget build(BuildContext context) {
    /// Resizing Container when size list change:
    // AnimateResultContainer(length) {
    //   if (searchResultContainerHeight < 0.36) {
    //     final size = 0.6 * length / 10;
    //     searchResultContainerHeight = searchResultContainerHeight + size;
    //   }
    // }

    ////////////////////////////////////
    /// RESPONSIVENESS :
    ////////////////////////////////////

    search_bar_left_pos = 0.33;

    search_cont_top_margin = 0.02;

    search_box_width = 0.20;

    search_bar_height = 50;

    search_box_top_margin = 5;

    search_text_fontSize = 16;

    search_iconSize = 22;

    search_bar_content_padding = 10;

    // DEFAULT :
    if (context.width > 1600) {
      search_bar_left_pos = 0.33;

      search_cont_top_margin = 0.02;

      search_bar_height = 50;

      search_box_width = 0.20;

      search_box_top_margin = 5;

      search_text_fontSize = 16;

      search_iconSize = 22;

      search_bar_content_padding = 10;
      print('Greator then 1600');
    }

    // DEFAULT :
    if (context.width < 1600) {
      search_bar_left_pos = 0.33;

      search_cont_top_margin = 0.02;

      search_box_width = 0.23;

      search_box_top_margin = 5;

      search_bar_height = 50;

      search_text_fontSize = 14;

      search_iconSize = 22;

      search_bar_content_padding = 10;
      print('1600');
    }

    // PC:
    if (context.width < 1500) {
      search_bar_left_pos = 0.33;

      search_cont_top_margin = 0.02;

      search_box_width = 0.21;

      search_bar_height = 50;

      search_box_top_margin = 5;

      search_text_fontSize = 14;

      search_iconSize = 22;

      search_bar_content_padding = 10;
      print('1500');
    }

    if (context.width < 1200) {
      search_bar_left_pos = 0.30;

      search_cont_top_margin = 0.02;

      search_box_width = 0.25;

      search_box_top_margin = 5;

      search_bar_height = 50;

      search_text_fontSize = 14;

      search_iconSize = 22;

      search_bar_content_padding = 10;
      print('1200');
    }

    if (context.width < 1000) {
      search_bar_left_pos = 0.27;

      search_cont_top_margin = 0.02;

      search_box_width = 0.35;

      search_box_top_margin = 5;

      search_bar_height = 45;

      search_text_fontSize = 14;

      search_iconSize = 20;

      search_bar_content_padding = 17;
      print('1000');
    }

    // TABLET :
    if (context.width < 800) {
      search_bar_left_pos = 0.25;

      search_cont_top_margin = 0.02;

      search_box_width = 0.35;

      search_box_top_margin = 5;

      search_bar_height = 42;

      search_text_fontSize = 14;

      search_iconSize = 20;

      search_bar_content_padding = 17;

      search_bar_top_margin = 2;
      print('800');
    }

    // SMALL TABLET:
    if (context.width < 640) {
      search_bar_left_pos = 0.05;

      search_cont_top_margin = 0.02;

      search_box_width = 0.50;

      search_box_top_margin = 7;

      search_bar_height = 40;


      search_text_fontSize = 13;

      search_iconSize = 18;

      search_bar_content_padding = 17;

      search_bar_top_margin = 2;
      
      print('640');
    }

    // PHONE:
    if (context.width < 480) {
      search_bar_left_pos = 0.05;

      search_cont_top_margin = 0.02;

      search_box_width = 0.40;
      
      search_bar_height = 35;

      search_box_top_margin = 7;

      search_text_fontSize = 12;

      search_iconSize = 15;

      search_bar_content_padding = 15;
      print('480');
    }

    return Positioned(
      left: context.width * search_bar_left_pos,
      top: search_bar_top_margin,
      child: Container(
          margin: EdgeInsets.only(top: context.height * search_cont_top_margin),
          child: SizedBox(
              width: context.width * search_box_width,
              child: Container(
                margin: EdgeInsets.only(top: search_box_top_margin),
                child: Column(
                  children: [
                    /// Search Input Field
                    SizedBox(
                        height: search_bar_height, child: SearchInputField()),

                    /// Show Search Results in list view
                    is_searching != true
                        ? Container()
                        : SeacrchResultsContainer(context)
                  ],
                ),
              ))),
    );
  }

/////////////////////////////////////////////
  /// External Methods:
  /// 1. Search input field :
  /// 2. Result Startup Contaienr :
  /// 3. Error Text widget :
  /// 4. Spinnser widget :
/////////////////////////////////////////////

////////////////////////////////////////////
  /// Search Input Field
////////////////////////////////////////////
  Container SearchInputField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade300)),
      child: TextField(
        controller: searchInputController,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(),
          color: Colors.black,
          fontSize: search_text_fontSize,
        ),
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: search_iconSize,
            ),
          ),
          hintText: 'Search',
          hintStyle: GoogleFonts.openSans(
            textStyle: TextStyle(),
            color: input_hind_color,
            fontSize: search_text_fontSize,
          ),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: search_bar_content_padding),
        ),
        onChanged: (val) {
          setState(() {
            if (val == '') {
              is_searching = false;
            } else {
              is_searching = true;
            }
            queryKeywords = val;
          });
        },
      ),
    );
  }

  /////////////////////////////////////////////////////
  /// Show Search Results in list view
  /////////////////////////////////////////////////////
  AnimatedContainer SeacrchResultsContainer(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: context.height * searchResultContainerHeight,
      width: context.width * 0.40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Card(
        color: Colors.grey.shade50,
        elevation: 2,
        shadowColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
              //Fetching Data :
              stream: SearchingAlgo(),

              // Building Data :
              builder: (context, snapshot) {
                // Show Loading while load data :
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SearchLoadingSpinner();
                }

                // If Connect has error then return error :
                if (snapshot.hasError) {
                  return SearchErrorWidget();
                }
                return StartupReslutTile(snapshot: snapshot);
              }),
        ),
      ),
    );
  }

  Container SearchErrorWidget() {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.bottomCenter,
      child: Text(
        'error',
        style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade300),
      ),
    );
  }

  Container SearchLoadingSpinner() {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.bottomCenter,
      child: CircularProgressIndicator(
        color: Colors.blueGrey.shade200,
        backgroundColor: Colors.grey.shade200,
        value: 5,
      ),
    );
  }
}
