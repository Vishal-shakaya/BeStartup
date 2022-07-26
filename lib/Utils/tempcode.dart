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