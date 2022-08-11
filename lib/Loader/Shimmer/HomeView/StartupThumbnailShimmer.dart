import 'package:flutter/material.dart';
import 'package:get/get.dart';

  Container StartupThumbnailShimmer(BuildContext context) {
    double image_cont_width = 0.46;
    double image_cont_height = 0.18;
    return Container(
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
          ),));
  }