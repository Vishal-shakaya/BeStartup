
import 'package:be_startup/Components/HomeView/SaveStories/StoryView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
class SaveStoryListView extends StatefulWidget {
  const SaveStoryListView({Key? key}) : super(key: key);

  @override
  State<SaveStoryListView> createState() => _SaveStoryListViewState();
}

class _SaveStoryListViewState extends State<SaveStoryListView> {
  @override
  Widget build(BuildContext context) {
  
    return Container(
      width: context.width*0.45,
      height:context.height*0.67,
      child: Swiper(
      // containerHeight: 200,
      // containerWidth: 200,
      scrollDirection : Axis.horizontal,
      itemCount: 3,
      pagination: SwiperPagination(
        builder: SwiperPagination.rect
      ),
      control: SwiperControl(
        color: Colors.blueGrey.shade100, 
        padding: EdgeInsets.only(top:context.height*0.04, right: 8.0), 
      ),

      // CONTENT SECTION : 
      itemBuilder: ((context, index) {
        return SaveStories();
      }),
    ));
  }


}
