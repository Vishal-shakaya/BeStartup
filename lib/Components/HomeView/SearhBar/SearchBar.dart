import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:endless/endless.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// tITLE TO SHOW SEARCH RESULTS :
class SearchStartupInfo {
  final String? startup_name;
  final String? startup_id;
  final String? startup_logo;
  final String? founder_name;

  SearchStartupInfo(
      {this.founder_name,
      this.startup_id,
      this.startup_logo,
      this.startup_name});
}

class SearchStartupHandler {
  static List<SearchStartupInfo>? batch = [];

  // Set Seach Object
  SearchObjectSetter({
    startup_len,
    startup_logo,
    startup_name,
    startup_id,
    founder_name,
  }) async {
    batch?.add(SearchStartupInfo(
        founder_name: founder_name,
        startup_name: startup_name,
        startup_id: startup_id,
        startup_logo: startup_logo));
  }

  //  Get Serch Object :
  SeachObjctGetter() async {
    return batch;
  }
}

class BusinessSearchBar extends StatefulWidget {
  BusinessSearchBar({Key? key}) : super(key: key);
  @override
  State<BusinessSearchBar> createState() => _BusinessSearchBarState();
}

class _BusinessSearchBarState extends State<BusinessSearchBar> {
  String? title;
  FirebaseFirestore store = FirebaseFirestore.instance;
  var searchHandler = SearchStartupHandler();
  var searchInputController = TextEditingController();
  

  var searchQuery;
  String queryKeywords = '';
  bool? is_searching = false;
  bool? is_searching_process = false;
  double searchResultContainerHeight = 0.35;

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
          height:
              context.height * searchResultContainerHeight,
          width: context.height * 0.40,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(5))),
          child: Card(
            color: Colors.grey.shade50,
            elevation: 2,
            shadowColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(

                //Fetching Data :
                stream: store
                    .collection(getBusinessDetailStoreName)
                    .where('startup_searching_index',
                        arrayContains: queryKeywords)
                    .snapshots(),


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


                    return ResultStartupTile(
                        snapshot: snapshot);
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
          child:Text('error', 
          style:TextStyle(
            fontSize: 14,
            color: Colors.blueGrey.shade300 
          ),),
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

class ResultStartupTile extends StatelessWidget {
  var snapshot;
  ResultStartupTile({
    required this.snapshot,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          key: UniqueKey(),
          primary: true,
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            // Data Conversion :
            var result_data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final startup_name = result_data['name'];
            final founder_name = result_data['founder_name'];
            final startup_id = result_data['startup_id'];
            final startup_logo = result_data['logo'];

            return Container(
              padding: EdgeInsets.all(3),
              child: ListTile(
                onTap: () {},

                // Startup Logo :
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(startup_logo, scale: 1)),

                // Startrup Hading :
                title: Text('${startup_name}',
                    style: TextStyle(color: light_color_type1, fontSize: 15),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis),

                // Username :
                subtitle: Text('@${founder_name}',
                    style: TextStyle(color: light_color_type3, fontSize: 12),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis),
              ),
            );
          }),
    );
  }
}
