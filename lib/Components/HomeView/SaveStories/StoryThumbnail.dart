import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveStoryThumbnail extends StatelessWidget {
  const SaveStoryThumbnail({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double image_cont_width = 0.46;
    double image_cont_height = 0.18;

    double image_thumb_width = 0.46;
    double image_thumb_height = 0.15;

    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
        left: Radius.circular(19),
        right: Radius.circular(19),
      )),
      child: Container(
          height: context.height * image_cont_height,
        width: context.width * image_cont_width,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20), right: Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(19),
            right: Radius.circular(19),
          ),
          child: Image.network(
              'https://www.postplanner.com/hubfs/how_to_get_more_likes_on_facebook.png',
              width: context.width * image_thumb_width,
              height:context.height * image_thumb_height,
              fit: BoxFit.cover),
        )),
                      );
  }
}