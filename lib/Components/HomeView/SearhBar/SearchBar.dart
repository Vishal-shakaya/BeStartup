import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:endless/endless.dart';

// tITLE TO SHOW SEARCH RESULTS :
class ExampleItem {
  final String title;

  ExampleItem({
    required this.title,
  });
}

// FETCH SEARCH ITEMS :
class ExampleItemPager {
  int pageIndex = 0;
  final int pageSize;

  ExampleItemPager({
    this.pageSize = 20,
  });

  nextBatch() {
    List<ExampleItem> batch = [];

    for (int i = 0; i < pageSize; i++) {
      batch.add(ExampleItem(title: 'Item ${pageIndex * pageSize + i}'));
    }

    pageIndex += 1;
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
  ExampleItemPager pager = ExampleItemPager();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:context.height*0.02),
        child: SizedBox(
            width: context.width * 0.30,
            child: PaginatedSearchBar<ExampleItem>(
                maxHeight: 300,
                hintText: 'Search',
                // placeholderBuilder: (context) {
                //   return const Text("I'm a placeholder state!");
                // },
                paginationDelegate: EndlessPaginationDelegate(
                  pageSize: 20,
                  maxPages: 3,
                ),

                itemBuilder: (
                  context, {
                  required item,
                  required index,
                }) {
                  return Text(item.title);
                },

                onSearch: ({
                  required pageIndex,
                  required pageSize,
                  required searchQuery,
                }) async {
                  return Future.delayed(const Duration(milliseconds: 1000), () {
                    if (searchQuery == "empty") {
                      return [];
                    }

                    if (pageIndex == 0) {
                      pager = ExampleItemPager();
                    }

                    return pager.nextBatch();
                  });
                })));
  }
}
