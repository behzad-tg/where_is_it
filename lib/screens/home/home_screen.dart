import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheretoeat/const.dart';
import 'package:wheretoeat/screens/home/pages/save_page.dart';
import 'package:wheretoeat/widgets/curved_navigation_bar.dart';

import 'controller.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeTabController homeTabController = Get.put(HomeTabController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: homeTabController.controller,
            dragStartBehavior: DragStartBehavior.down,
            children: const [
              Directionality(
                  textDirection: TextDirection.rtl, child: SearchPage()),
              Directionality(
                  textDirection: TextDirection.rtl, child: HomePage()),
              Directionality(
                  textDirection: TextDirection.rtl, child: SavePage()),
            ],
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: primaryBlue,
              height: 70,
              index: 1,
              items: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.search, size: 20, color: Colors.white),
                    Text(
                      'جستجو',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_pin, size: 20, color: Colors.white),
                    Text('نقشه',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.book, size: 20, color: Colors.white),
                    Text('ذخیره ها',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))
                  ],
                ),
              ],
              onTap: (index) {
                homeTabController.controller.index = index;
              },
            ),
          ),
        ],
      ),
    );
  }
}
