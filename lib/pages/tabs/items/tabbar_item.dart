import 'package:flutter/material.dart';

import '../all_screen.dart';
import '../completed_screen.dart';
import '../favorite_screen.dart';
import '../uncompleted_screen.dart';

class TabBarItem extends StatefulWidget {
  const TabBarItem({Key? key}) : super(key: key);

  @override
  _TabBarItemState createState() => _TabBarItemState();
}

class _TabBarItemState extends State<TabBarItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Column(
            children: [
              const TabBar(
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorWeight: 3,
                  indicatorPadding:
                      EdgeInsetsDirectional.only(start: 12, end: 12),
                  indicatorColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                    Tab(
                      text: 'UnCompleted',
                    ),
                    Tab(
                      text: 'Favorite',
                    ),
                  ]),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5))),
                height: 500,
                child: const TabBarView(children: [
                  AllScreen(),
                  CompletedScreen(),
                  UnCompletedScreen(),
                  FavoriteScreen(),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
