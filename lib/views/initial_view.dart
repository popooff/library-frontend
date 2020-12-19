import 'package:library_frontend/widgets/library_bottom_nav_bar.dart';
import 'package:library_frontend/views/client_page/profile_page.dart';
import 'package:library_frontend/views/client_page/search_page.dart';
import 'package:library_frontend/views/client_page/home_page.dart';
import 'package:flutter/material.dart';


class Initial extends StatefulWidget {

  @override
  _InitialState createState() => _InitialState();
}


class _InitialState extends State<Initial> {

  final pages = [
    Search(),
    Home(),
    Profile(),
  ];

  int currentPage = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,

      body: SafeArea(
        bottom: false,
        child: pages[currentPage],
      ),

      bottomNavigationBar: LibraryBottomBar(
          bottoms: [
            IconButton(
                icon: Icon(
                    Icons.search,
                    color: (currentPage == 0) ? Colors.black : Colors.white
                ),
                onPressed: () {
                  setState(() {
                    currentPage = 0;
                  });
                }),

            IconButton(
                icon: Icon(
                    Icons.home,
                    color: (currentPage == 1) ? Colors.black : Colors.white
                ),
                onPressed: () {
                  setState(() {
                    currentPage = 1;
                  });
                }),

            IconButton(
                icon: Icon(
                    Icons.account_circle,
                    color: (currentPage == 2) ? Colors.black : Colors.white
                ),
                onPressed: () {
                  setState(() {
                    currentPage = 2;
                  });
                }),
          ]
      ),
    );

  }
}
