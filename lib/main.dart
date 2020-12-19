import 'package:library_frontend/services/routes.dart';
import 'package:flutter/material.dart';


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
