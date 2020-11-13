import 'package:flutter/material.dart';
import 'package:library_frontend/models/user.dart';
import 'package:library_frontend/services/rest_api/user_api.dart';
import 'package:library_frontend/views/authentication/login_page.dart';
import 'package:library_frontend/widgets/my_alert.dart';
import 'package:blobs/blobs.dart';


class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  UserApi userApi;
  bool obscurePassword = true;
  TextEditingController nameController;
  TextEditingController surnameController;
  TextEditingController emailController;
  TextEditingController passwordController;

  final blobs = [
    ['17-5-67'],
    ['17-5-32'],
    ['17-5-91724'],
    ['17-5-800']
  ];


  @override
  void initState() {
    userApi = UserApi();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
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

            child: Blob.fromID(
                size: 500,
                id: (blobs..shuffle()).first,
                styles: BlobStyles(
                  gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.3),
                        Colors.blueAccent.withOpacity(0.4),
                      ]).createShader(Rect.fromLTRB(0, 100, 200, 300)),
                ),

                child: Padding(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  child: ListView(
                      children: [

                        SizedBox(
                          height: 120,
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Library\nRegistration',
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: (MediaQuery.of(context).size.width - 40) / 2,
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    labelText: 'Nome',
                                    border: OutlineInputBorder()
                                ),
                              ),
                            ),

                            Container(
                              height: 40,
                              width: (MediaQuery.of(context).size.width - 40) / 2,
                              child: TextField(
                                controller: surnameController,
                                decoration: InputDecoration(
                                    labelText: 'Cognome',
                                    border: OutlineInputBorder()
                                ),
                              ),
                            ),
                          ]),

                        SizedBox(
                          height: 5,
                        ),

                        Container(
                          height: 40,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: 'E-mail',
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

                            var user = User(
                                name: nameController.text,
                                surname: surnameController.text,
                                email: emailController.text,
                                password: userApi.sha256Encrypt(passwordController.text)
                            );

                            bool registered = await userApi.registerUser(user);

                            if (registered) {

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return LoginPage(user: user);
                                      })
                              );

                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => MyAlertDialog(
                                      content: 'Registrazione non riuscita!'
                                  )
                              );
                            }
                          },
                          child: Text('Register'),
                          textColor: Colors.white,
                          color: Colors.blue,
                        ),

                        Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Hai un account?'),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Accedi')
                                )
                              ])
                        ),
                      ]),
                )
            ),
          ),
        )
    );
  }

}
