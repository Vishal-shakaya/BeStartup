import 'package:be_startup/Components/HomeView/SearhBar/StartupResultTIle.dart';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
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


 /////////////////////////////////////////////////////
 /// It takes a string as input and returns 
 /// a stream of documents from firestore
 /// 
 /// Returns:
 ///   A stream of QuerySnapshot<Map<String, dynamic>>
 /////////////////////////////////////////////////////
  SearchingAlgo() {
    Stream<QuerySnapshot<Map<String, dynamic>>> startupStream;
    Stream<QuerySnapshot<Map<String, dynamic>>> founderStream;
    Stream<QuerySnapshot<Map<String, dynamic>>>? mainStream;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList = [];

    if (queryKeywords.contains('@')) {
      var new_key = queryKeywords.replaceAll('@', '');
      new_key = new_key.trim();
      mainStream = store
          .collection(getBusinessDetailStoreName)
          .where('founder_searching_index', arrayContains: new_key)
          .snapshots();

    } 

    else {
      mainStream = store
          .collection(getBusinessDetailStoreName)
          .where('startup_searching_index', arrayContains: queryKeywords)
          .snapshots();
    }

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

    return Positioned(
      left: context.width * 0.34,
      child: Container(
          margin: EdgeInsets.only(top: context.height * 0.02),
          child: SizedBox(
              width: context.width * 0.20,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    /// Search Input Field
                    SearchInputField(),

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
          fontSize: 16,
        ),
        decoration: const InputDecoration(
          icon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          hintText: 'Search',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5),
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
      width: context.height * 0.40,
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
