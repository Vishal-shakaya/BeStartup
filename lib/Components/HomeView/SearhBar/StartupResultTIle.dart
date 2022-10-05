import 'dart:convert';
import 'package:be_startup/AppState/User.dart';
import 'package:be_startup/Utils/Colors.dart';
import 'package:be_startup/Utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartupReslutTile extends StatelessWidget {
  var snapshot;
  StartupReslutTile({
    required this.snapshot,
    Key? key,
  }) : super(key: key);

  var userState = Get.put(UserState());
  @override
  Widget build(BuildContext context) {
    //////////////////////////////////
    /// Detail view url :
    //////////////////////////////////
    StartupDetailView({
      required founder_id,
      required startup_id,
    }) async {
      var is_admin = false;
      var user_id = await userState.GetUserId();

      if (user_id == founder_id) {
        is_admin = true;
      }
      var param = {
        'founder_id': founder_id,
        'startup_id': startup_id,
        'is_admin': is_admin,
      };

      Navigator.of(context).pop();
      Get.toNamed(startup_view_url, parameters: {'data': jsonEncode(param)});
    }

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

            print('Result Data ${result_data}');

            // print(result_data);
            final startup_name = result_data['name'];
            final founder_name = result_data['founder_name'];
            final startup_id = result_data['startup_id'];
            final startup_logo = result_data['logo'];
            final founder_id = result_data['founder_id'];

            return Container(
              padding: EdgeInsets.all(3),
              child: ListTile(
                onTap: () async {
                  await StartupDetailView(
                      startup_id: startup_id, founder_id: founder_id);
                },

                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),

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
