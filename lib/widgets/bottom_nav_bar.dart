import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/download_screen.dart';
import 'package:netflix_clone/screens/homescreen.dart';
import 'package:netflix_clone/screens/more_screen.dart';
import 'package:netflix_clone/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.file_download),
                text: "Downloads",
              ),
              Tab(
                icon: Icon(Icons.list),
                text: "More",
              ),
            ],
            unselectedLabelColor: Color(0xFF999999),
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            HomeScreen(),
            SearchScreen(),
            DownloadScreen(),
            MoreScreen(),
          ],
        ),
      ),
    );
  }
}
