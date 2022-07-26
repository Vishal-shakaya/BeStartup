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

  ////////////////////////////////////////////////
  /// Searching Algo:
  //////////////////////////////////////////////////
  SearchQuery({keywords}) async {
    final lower_key = keywords.toString().toLowerCase();
    var resutl_list;
    searchQuery = store
        .collection(getBusinessDetailStoreName)
        .where('startup_searching_index', arrayContains: lower_key)
        .get();

    await searchQuery.then((element) {
      for (var doc in element.docs) {
        var startup_length = 1;
        final name = doc.data()['name'];
        final founder_name = doc.data()['founder_name'];
        final startup_id = doc.data()['startup_id'];
        final startup_logo = doc.data()['logo'];
        // print('startupLength $startup_length');
        // print(name);
        // print(founder_name);
        // print(startup_id);
        // print(startup_logo);

        startup_length += 1;
        searchHandler.SearchObjectSetter(
            startup_id: startup_id,
            startup_name: name,
            startup_logo: startup_logo,
            founder_name: founder_name,
            startup_len: startup_length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // searchQuery = store.collection(getBusinessDetailStoreName).snapshots();
    return Positioned(
      left:context.width*0.34, 
      child: Container(
          margin: EdgeInsets.only(top: context.height * 0.02),
          child: SizedBox(
              width: context.width * 0.20,
              child: Container(
              margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    /////////////////////////////////
                    /// Search Input Field
                    /////////////////////////////////
                    Container(
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
                          print(val);
                        },
                      ),
                    ),
    
                    /////////////////////////////////////////////////////
                    /// Show Search Results in list view
                    /////////////////////////////////////////////////////
                    AnimatedContainer(
                      duration: Duration(milliseconds: 800),
                      height: context.height * 0.35,
                      width: context.height * 0.40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Card(
                        color: Colors.grey.shade50,
                        elevation: 2,
                        shadowColor: shadow_color1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              key: UniqueKey(),
                              primary: true,
                              scrollDirection: Axis.vertical,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(3),
                                  child: ListTile(
                                    onTap: () {
                                      print("Hello");
                                    },
    
                                    // Startup Logo :
                                    leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            temp_avtar_image,
                                            scale: 1)),
    
                                    // Startrup Hading :
                                    title: Text('heading of startup $index',
                                        style: TextStyle(
                                            color: light_color_type1,
                                            fontSize: 15),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis),
    
                                    // Username :
                                    subtitle: Text('@username',
                                        style: TextStyle(
                                            color: light_color_type3,
                                            fontSize: 12),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
