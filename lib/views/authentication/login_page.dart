import 'package:flutter/material.dart';
import 'package:library_frontend/services/rest_api/user_api.dart';
import 'package:library_frontend/widgets/my_alert.dart';
import '../../models/user.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  UserApi userApi;
  bool obscurePassword = true;
  bool log = false;
  TextEditingController emailController;
  TextEditingController passwordController;


  @override
  void initState() {
    userApi = UserApi();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView(
                children: [

                  Image.asset(
                    'assets/library_login.png',
                    height: 280,
                  ),

                  Container(
                    height: 40,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    height: 40,
                    child: TextField(
                      obscureText: obscurePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword ? obscurePassword = false : obscurePassword = true;
                              });
                            },
                            icon: (obscurePassword) ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                          )
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  FlatButton(
                    onPressed: () async {

                      setState(() {
                        log = true;
                      });

                      bool logged = await userApi.loginUser(
                          User(
                              email: emailController.text,
                              password: userApi.sha256Encrypt(passwordController.text)
                          )
                      );

                      if (logged) {
                        Navigator.pushReplacementNamed(context, '/initial');

                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => MyAlertDialog(
                                content: 'Login non riuscito!'
                            )
                        );
                      }

                    },
                    child: log ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                      )) : Text('Login'),
                    textColor: Colors.white,
                    color: Colors.blue.shade300,
                  ),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Non hai un account?'),
                        FlatButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/register');
                            },
                            child: Text('Registrati')
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
