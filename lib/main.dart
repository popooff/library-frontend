import 'package:flutter/material.dart';
import 'package:library_frontend/services/routes.dart';
import 'package:library_frontend/views/home_page.dart';
import 'package:library_frontend/views/profile_page.dart';
import 'package:library_frontend/views/search_page.dart';
import 'package:library_frontend/widgets/library_drawer.dart';
import 'widgets/library_bottom_nav_bar.dart';


void main() => runApp(Library());


class Library extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}


class Initial extends StatefulWidget {

  @override
  _InitialState createState() => _InitialState();
}


class _InitialState extends State<Initial> {

  final pages = [
    SearchPage(),
    Home(),
    ProfilePage(),
  ];

  int currentPage = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,

      drawer: LibraryDrawer(),
      body: pages[currentPage],

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
