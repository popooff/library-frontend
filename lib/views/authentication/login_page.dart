import 'package:flutter/material.dart';
import 'package:library_frontend/services/rest_api/user_api.dart';
import 'package:library_frontend/widgets/my_alert.dart';
import '../../models/user.dart';
import 'package:blobs/blobs.dart';


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

          child: Blob.animatedFromID(
            size: 500,
            id:['11-5-380321', '11-5-990', '11-5-76607', '11-5-31'],
            duration: Duration(seconds: 3),
            styles: BlobStyles(
              gradient: LinearGradient(
                  colors: [
                    Colors.red.withOpacity(0.45),
                    Colors.blueAccent.withOpacity(0.25),
                  ]).createShader(Rect.fromLTRB(0, 100, 200, 300)),
            ),
            loop: true,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView(
                children: [

                  SizedBox(
                    height: 120,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Library      \nLogin',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
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

                        setState(() {
                          log = logged;
                        });

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
                    color: Colors.blue.shade400,
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
                ]),
            ),
          ),
        ),
      ),
    );
  }

}
