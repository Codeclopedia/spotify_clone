// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:spotify_clone/widgets/customBarIcons.dart';
import 'package:spotify_clone/widgets/tabpages/Home.dart';
import 'package:spotify_clone/widgets/tabpages/librarypage.dart';
import 'package:spotify_clone/widgets/tabpages/premiumPage.dart';
import 'package:spotify_clone/widgets/tabpages/searchPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map> tabIconData = [
    {"icon": Icons.home, "title": "Home"},
    {"icon": Icons.search, "title": "Search"},
    {"icon": Icons.library_music, "title": "Library"},
    {"icon": Icons.person, "title": "Premium"},
  ];
  List tabs = [Home(), SearchPage(), const LibraryPage(), const PremiumPage()];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        tabs[currentindex],
        customBottomNavigationBar(),
      ],
    ));
  }

  Widget customBottomNavigationBar() {
    return Positioned(
      bottom: 0,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.0, 0.5),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
              colors: [
                Colors.transparent,
                Color.fromARGB(239, 0, 0, 0),
              ],
            ),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tabIconData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (() => setState(() {
                      currentindex = index;
                    })),
                child: CustomBarIcons(
                    icon: tabIconData[index]["icon"],
                    title: tabIconData[index]["title"],
                    isSelected: currentindex == index ? true : false),
              );
            },
          )),
    );
  }
}
