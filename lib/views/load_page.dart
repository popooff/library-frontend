import 'package:library_frontend/views/authentication/login_page.dart';
import 'package:library_frontend/views/initial_view.dart';
import 'package:library_frontend/services/utils.dart';
import 'package:flutter/material.dart';


class LoadPage extends StatefulWidget {

  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {

  Utils utils = Utils();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: utils.isValid(),
      builder: (context, data) {

        if (data.data == null) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );

        } else {

          if (data.data) {
            return LoginPage();

          } else {
            return Initial();
          }
        }

      },
    );
  }
}
