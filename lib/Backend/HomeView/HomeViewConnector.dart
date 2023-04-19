import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Models/Models.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class HomeViewConnector extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;

  FetchStartups() async {
    var startup_data;
    var startup_ids = [];
    var founder_ids = [];
    var startup_len;
    var startup_names = [];

    // FETCHING DATA FROM FIREBASE
    try {
      var startup = await FirebaseFirestore.instance
          .collection(getBusinessDetailStoreName)
          .get()
          .then((value) {
        startup_len = value.size;
        for (var doc in value.docs) {
          founder_ids.add(doc.data()['user_id']);
          startup_names.add(doc.data()['name']);
        }
      });
      startup_data = {
        'user_id': founder_ids,
        'startup_len': startup_len,
        'startup_name': startup_names
      };

      return ResponseBack(response_type: true, data: startup_data);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }



  FetchUserStartups({required user_id}) async {
    var startup_data;
    var startup_ids = [];
    var user_ids;
    var startup_len;
    var startup_names;

    // FETCHING DATA FROM FIREBASE
    try {
      var startup = await FirebaseFirestore.instance
          .collection(getBusinessDetailStoreName)
          .where('user_id', isEqualTo: user_id)
          .get()
          .then((value) {
        startup_len = value.size;
        for (var doc in value.docs) {
          user_ids = doc.data()['user_id'];
          startup_names = doc.data()['name'];
        }
      });
      startup_data = {
        'user_id': user_ids,
        'startup_len': startup_len,
        'startup_name': startup_names
      };

      return ResponseBack(response_type: true, data: startup_data);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }



/////////////////////////////////////////////
/// It fetches the data from the firestore database
/// and returns the data in the form of a map
/// Args:
///   user_id: The user id of the user whose saved startups are to be fetched.
/// Returns:
///   A ResponseBack object.
/////////////////////////////////////////////
  FetchSaveStartups({user_id}) async {
    var startup_data;
    var user_ids = [];
    var founder_ids = [];
    var startup_len;
    var startup_names = [];

    try {
      ////////////////////////////////////
      // Fetch user Sava Startups :
      ////////////////////////////////////
      var save_startups = await store.collection(getSaveStartupStoreName);
      var query = save_startups.where("user_id", isEqualTo: user_id).get();

      await query.then((value) {
        for (var data in value.docs) {
          user_ids = data.data()['user_ids'];
        }
      });

      //////////////////////////////////
      /// Fetch Startups Data :
      /// /////////////////////////////////
      var startup_store = await store.collection(getBusinessDetailStoreName);
      var query2 = startup_store.where('user_id', whereIn: user_ids).get();

      await query2.then((value) {
        for (var doc in value.docs) {
          founder_ids.add(doc.data()['user_ids']);
          startup_names.add(doc.data()['name']);
        }
      });

      startup_data = {
        'user_idss': user_ids,
        'user_id': founder_ids,
        'startup_len': user_ids.length,
        'startup_name': startup_names
      };

      // print(startup_data);
      return ResponseBack(response_type: true, data: startup_data);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }




  FetchExploreStartups({DateTime? start_date, DateTime? end_date, catigories}) async {
    // print('start at $start_date');
    // print('end at $end_date');
    // print('catigory $catigories');

    var startup_data;
    var startup_id;
    var startup_ids = [];
    var founder_ids = [];
    var startup_len;
    var startup_names = [];

    try {
      ////////////////////////////////////
      // Fetch user Sava Startups :
      ////////////////////////////////////

      print('Step 1 Start');

      var save_startups = await store.collection(getBusinessCatigoryStoreName);

      var lessThan =
          save_startups.where('timestamp', isLessThanOrEqualTo: end_date).get();

      var greaterThan = save_startups
          .where('timestamp', isGreaterThanOrEqualTo: start_date)
          .get();

      var catigory =
          save_startups.where('catigories', arrayContainsAny: catigories).get();

      await catigory.then((value) {
        for (var data in value.docs) {
          startup_id = data.data()['startup_id'];
          startup_ids.add(startup_id);
        }
      }).onError((error, stackTrace) {
        print('Less than Error ${error}');
      });

      await lessThan.then((value) {
        for (var data in value.docs) {
          startup_id = data.data()['startup_id'];
          startup_ids.add(startup_id);
        }
      }).onError((error, stackTrace) {
        print('Less than Error ${error}');
      });

      await greaterThan.then((value) {
        for (var data in value.docs) {
          startup_id = data.data()['startup_id'];
          startup_ids.add(startup_id);
        }
      }).onError((error, stackTrace) {
        print('Greator than Error ${error}');
      });

      //////////////////////////////////
      /// Fetch Startups Data :
      /// /////////////////////////////////
      var startup_store = await store.collection(getBusinessDetailStoreName);
      var startup_query =
          startup_store.where('startup_id', whereIn: startup_ids).get();

      await startup_query.then((value) {
        for (var doc in value.docs) {
          founder_ids.add(doc.data()['founder_id']);
          startup_names.add(doc.data()['name']);
        }
      });

      startup_data = {
        'startup_ids': startup_ids,
        'founder_id': founder_ids,
        'startup_len': startup_ids.length,
        'startup_name': startup_names
      };

      // print(startup_data);
      return ResponseBack(response_type: true, data: startup_data);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  FetchLikeStartups({user_id}) async {
    var startup_data;
    var user_ids = [];
    var founder_ids = [];
    var startup_len;
    var startup_names = [];

    try {
      ////////////////////////////////////
      // Fetch user Sava Startups :
      ////////////////////////////////////
      var save_startups = await store.collection(getLikeStartupStoreName);
      var query = save_startups.where("user_id", isEqualTo: user_id).get();

      await query.then((value) {
        for (var data in value.docs) {
          user_ids = data.data()['user_ids'];
        }
      });

      //////////////////////////////////
      /// Fetch Startups Data :
      /// /////////////////////////////////
      var startup_store = await store.collection(getBusinessDetailStoreName);
      var query2 = startup_store.where('id', whereIn: user_ids).get();

      await query2.then((value) {
        for (var doc in value.docs) {
          founder_ids.add(doc.data()['founder_id']);
          startup_names.add(doc.data()['name']);
        }
      });

      startup_data = {
        'user_ids': user_ids,
        'founder_id': founder_ids,
        'user_ids': user_ids.length,
        'startup_name': startup_names
      };

      // print(startup_data);
      return ResponseBack(response_type: true, data: startup_data);
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  /////////////////////////////////////////////////////
  /// It checks if the user has saved any query  before, if not,
  /// it creates a new document with the user
  /// id and the startup id. If the user has saved a startup before,
  /// it adds the new startup id to the
  /// list of startup ids
  ///
  /// Args:
  ///   startup_id: The id of the startup you want to save.
  ///   user_id: The user id of the user who is saving the startup
  ///
  /// Returns:
  ///   A Future<ResponseBack>
  /////////////////////////////////////////////////////
  SaveStartup({required user_id , required startup_user_id }) async {
    final localStore = await SharedPreferences.getInstance();
    var doc_id;
    var data;
    var save_post_len;
    var user_ids = [];

    try {
      final myStore = store.collection(getSaveStartupStoreName);
      var query = myStore.where('user_id', isEqualTo: user_id).get();

      await query.then((value) {
        save_post_len = value.size;
        // print('Save post len $save_post_len');
        if (save_post_len > 0) {
          user_ids = value.docs.first.data()['user_ids'];
          data = value.docs.first.data();
          doc_id = value.docs.first.id;
          // print('Save post len ${value.docs.first.data()}');
        }
      });

      // Check if post already Saved :
      if (user_ids.contains(user_id)) {
        return ResponseBack(
            response_type: false, message: 'Startup Already Saved', code: 101);
      }

      // Add new Save Story Doc :
      if (save_post_len <= 0) {
        user_ids.add(startup_user_id);
        var save_startup = await SaveStartupsModel(
          user_id: user_id,
          user_ids: user_ids,
        );
        print('Model $user_ids');

        await myStore.add(save_startup);
        return ResponseBack(
            response_type: true, message: 'First Startup Add to List ');
      }

      if (save_post_len > 0) {
        user_ids.add(startup_user_id);
        data['user_ids'] = user_ids;
        await myStore.doc(doc_id).update(data);
        return ResponseBack(response_type: true, message: 'Startup Saved');
      }
    } catch (e) {
      print('Error While Saving Startup $e');
      return ResponseBack(response_type: false, message: e);
    }
  }

  ////////////////////////////////////////////////////////
  /// It gets the list of saved startups from the database,
  /// removes the startup_id from the list and
  /// updates the database with the new list
  /// Args:
  ///   startup_id: The id of the startup to be unsaved
  ///   user_id: The user's ID
  ///////////////////////////////////////////////////////////
  UnsaveStartup({required user_id}) async {
    final localStore = await SharedPreferences.getInstance();
    var doc_id;
    var data;
    var save_post_len;
    var startup_list = [];
    try {
      final myStore = store.collection(getSaveStartupStoreName);
      var query = myStore.where('user_id', isEqualTo: user_id).get();
      await query.then((value) {
        save_post_len = value.size;
        // print('size $save_post_len');
        if (save_post_len > 0) {
          // print(' 1. UnSave Post Process Start');
          startup_list = value.docs.first.data()['user_ids'];
          // print(' 2. Get startup list $startup_list');
          data = value.docs.first.data();
          // print(' 3. Data $data');
          doc_id = value.docs.first.id;
          // print(' 4. Document ID  $doc_id');
        }
      });

      // Validate :
      if (save_post_len <= 0) {
        return ResponseBack(response_type: false);
      }

      if (save_post_len > 0) {
        // print("5. Update Startup List with new list ");
        startup_list.remove(user_id);
        data['user_ids'] = startup_list;
        await myStore.doc(doc_id).update(data);
        // print('6. Unsave Update Startup List');
        return ResponseBack(response_type: true, message: 'Startup UnSaved');
      }
    } catch (e) {
      ResponseBack(response_type: false, message: e);
    }
  }

///////////////////////////////////////////////////////////////
  /// It checks if the user has saved the startup or not
  /// Args:
  ///   startup_id: The id of the startup that the user wants to save.
  ///   user_id: The user id of the user who is logged in
  ///
  /// Returns:
  ///   ResponseBack is a class that returns a response.
///////////////////////////////////////////////////////////////
  IsStartupSaved({user_id , required startup_user_id}) async {
    var save_post_len;
    var startup_list = [];

    try {
      final myStore = store.collection(getSaveStartupStoreName);
      var query = myStore.where('user_id', isEqualTo: user_id).get();
     
      await query.then((value) {
        save_post_len = value.size;
        if (save_post_len > 0) {
          startup_list = value.docs.first.data()['user_ids'];
        }
      });


      // Check if post already Saved :
      if (startup_list.contains(user_id)) {
        return ResponseBack(
            response_type: true, message: 'Startup Already Saved', code: 101);
      } else {
        return ResponseBack(response_type: true, code: 111);
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
