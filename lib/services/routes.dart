import 'package:flutter/material.dart';
import 'package:library_frontend/main.dart';
import 'package:library_frontend/views/authentication/login_page.dart';


class Routes {

  static Route<dynamic> routes(RouteSettings settings) {

    switch (settings.name) {

      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
        break;

      case '/initial':
        return MaterialPageRoute(builder: (_) => Initial());
        break;

      case '/reservation':
        return MaterialPageRoute(builder: (_) => null);
        break;

      case '/return':
        return MaterialPageRoute(builder: (_) => null);
        break;

      default:
        return errorPage();
    }
  }


  static Route<dynamic> errorPage() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Container(
            child: Center(
                child: Text(
                    'Page not found!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )
                )
            ),
          ),
        )
    );
  }

}
