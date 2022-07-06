import 'dart:convert';
import 'package:be_startup/Helper/StartupSlideStoreName.dart';
import 'package:be_startup/Utils/Messages.dart';
import 'package:be_startup/Utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartupConnector extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;

  ///////////////////////////////////////////////////////
  // 1. Get Data form local storage :
  // 2. if has data then Store in Firebase Databse :
  //////////////////////////////////////////////////////
  CreateStartup() async {
    final localStore = await SharedPreferences.getInstance();
    final myStore = store.collection(getStartupStoreName);
    try {
      // kye : BusinessCatigory
      bool is_data = localStore.containsKey(getStartupStoreName);

      if (is_data) {
        String? temp_data = localStore.getString(getStartupStoreName);
        Map<String, dynamic> data = json.decode(temp_data!);

        await myStore.add(data);
        return ResponseBack(
            response_type: true,
            message: 'Create Startup Successfully');
      } else {
        return ResponseBack(
            response_type: false, message: 'Startup ${cached_error} ');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


  CreateBusinessPlans() async {
    final localStore = await SharedPreferences.getInstance();
    final myStore = store.collection(getStartupPlansStoreName);
    try {
      // kye : BusinessCatigory
      bool is_data = localStore.containsKey(getStartupPlansStoreName);

      if (is_data) {
        String? temp_data = localStore.getString(getStartupPlansStoreName);
        Map<String, dynamic> data = json.decode(temp_data!);

        await myStore.add(data);
        return ResponseBack(
            response_type: true,
            message: 'Create Plan Successfully');
      } else {
        return ResponseBack(
            response_type: false, message: 'Plan ${cached_error} ');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


  ///////////////////////////////////////////////////////
  // 1. Get Data form local storage :
  // 2. if has data then Store in Firebase Databse :
  //////////////////////////////////////////////////////
  CreateBusinessCatigory() async {
    final localStore = await SharedPreferences.getInstance();
    final myStore = store.collection(getBusinessCatigoryStoreName);
    try {
      // kye : BusinessCatigory
      bool is_data = localStore.containsKey(getBusinessCatigoryStoreName);

      if (is_data) {
        String? temp_data = localStore.getString(getBusinessCatigoryStoreName);
        Map<String, dynamic> data = json.decode(temp_data!);

        await myStore.add(data);
        return ResponseBack(
            response_type: true,
            message: 'Create BusinessCatigory Successfully');
      } else {
        return ResponseBack(
            response_type: false, message: 'BusinessCatigory ${cached_error} ');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


/////////////////////////////////////////
/// Upload Business Detial : 
// 1. Get Data form local storage :
// 2. if has data then Store in Firebase Databse :
/////////////////////////////////////////
  CreateBusinessDetail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getBusinessDetailStoreName);

      // fetch catigories for local storage :
      // kye : BusinessDetail
      bool is_data = localStore.containsKey(getBusinessDetailStoreName);
      // Validate key :
      if (is_data) {
        String? temp_data = localStore.getString(getBusinessDetailStoreName);
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(
            response_type: true, message: 'Create BusinessDetail Successfully');
      } else {
        return ResponseBack(
          response_type: false,
          message: 'BusinessDetail ${cached_error} ',
        );
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

  /////////////////////////////////////////
  // Upload Milestone : 
  /////////////////////////////////////////
  CreateBusinessMileStone() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getBusinessMilestoneStoreName);

      // fetch catigories for local storage :
      // kye : BusinessMilestones
      bool is_data = localStore.containsKey(getBusinessMilestoneStoreName);
      // Validate key :
      if (is_data) {
        String? temp_data = localStore.getString(getBusinessMilestoneStoreName);
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(
          response_type: true,
          message: 'Create BusinessMilestones Successfully',
        );
      } else {
        return ResponseBack(
            response_type: false,
            message: 'BusinessMilestones ${cached_error} ');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


  //////////////////////////////////////////
  /// Upload Products :
  //////////////////////////////////////////
  CreateBusinessProduct() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection('BusinessProducts');

      // fetch catigories for local storage :
      // kye : BusinessProducts

      bool is_data = localStore.containsKey('BusinessProducts');
      // Validate key :
      if (is_data) {
        String? temp_data = localStore.getString('BusinessProducts');
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(
            response_type: true,
            message: 'Create BusinessProduct Successfully');
      } else {
        return ResponseBack(
            response_type: false, message: 'BusinessProduct ${cached_error} ');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


/////////////////////////////////////////////////
/// Upload Vision : 
/////////////////////////////////////////////////
  CreateBusinessVision() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getBusinessVisiontStoreName);

      // fetch catigories for local storage :
      // kye : BusinessVision
      bool is_data = localStore.containsKey(getBusinessVisiontStoreName);
      // Validate key :
      if (is_data) {
        String? temp_data = localStore.getString(getBusinessVisiontStoreName);
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(
            response_type: true, message: 'Create BusinessVision Successfully');
      } else {
        return ResponseBack(
            response_type: false, message: 'BusinessVision ${cached_error} ');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }


/////////////////////////////////////////////////
/// Upload Why Text : 
/////////////////////////////////////////////////
  CreateBusinessWhyInvest() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getBusinessWhyInvesttStoreName);

      // fetch catigories for local storage :
      // kye : BusinessVision
      bool is_data = localStore.containsKey(getBusinessWhyInvesttStoreName);
      // Validate key :
      if (is_data) {
        String? temp_data = localStore.getString(getBusinessWhyInvesttStoreName);
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(
            response_type: true, message: 'Create BusinessWhyInvest Successfully');
      } else {
        return ResponseBack(
            response_type: false, message: 'BusinessWhyInvest ${cached_error} ');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }




/////////////////////////////////////////////////
/// Upload Thumbnail :  
/////////////////////////////////////////////////
  CreateBusinessThumbnail() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getBusinessThumbnailStoreName);

      // fetch catigories for local storage :
      // kye : BusinessThumbnail

      bool is_data = localStore.containsKey(getBusinessThumbnailStoreName);
      // Validate key :
      if (is_data) {
        String? temp_data = localStore.getString(getBusinessThumbnailStoreName);
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(
            response_type: true,
            message: 'Create BusinessThumbnail Successfully');
      } else {
        return ResponseBack(
            response_type: false,
            message: 'BusinessThumbnail ${cached_error} ');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }

///////////////////////////////////////////////
/// Upload Team Member : 
///////////////////////////////////////////////
  CreateBusinessTeamMember() async {
    final localStore = await SharedPreferences.getInstance();
    try {
      final myStore = store.collection(getBusinessTeamMemberStoreName);

      // fetch catigories for local storage :
      // kye : BusinessTeamMember
      bool is_data = localStore.containsKey(getBusinessTeamMemberStoreName);
      // Validate key :
      if (is_data) {
        String? temp_data = localStore.getString(getBusinessTeamMemberStoreName);
        var data = json.decode(temp_data!);

        // Store Data in Firebase :
        await myStore.add(data);
        return ResponseBack(
            response_type: true,
            message: 'Create BusinessTeamMember Successfully');
      } else {
        return ResponseBack(
            response_type: false,
            message: 'BusinessTeamMember ${cached_error} ');
      }
    } catch (e) {
      return ResponseBack(response_type: false, message: e);
    }
  }
}
