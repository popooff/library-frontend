import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:library_frontend/models/user.dart';
import 'package:library_frontend/services/rest_api/user_api.dart';
import 'package:library_frontend/widgets/my_alert.dart';

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
        child: Blob.animatedFromID(
            size: 500,
            id: ['17-5-67', '17-5-32', '17-5-91724', '17-5-800'],
            duration: Duration(seconds: 3),
            styles: BlobStyles(
              gradient: LinearGradient(colors: [
                Colors.blueAccent.withOpacity(0.2),
                Colors.blue.withOpacity(0.4),
              ]).createShader(Rect.fromLTRB(0, 100, 200, 300)),
            ),
            loop: true,
            child: Padding(
              padding: EdgeInsets.only(right: 15, left: 15),
              child: ListView(children: [
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
                        fontWeight: FontWeight.bold),
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
                              labelText: 'Nome', border: OutlineInputBorder()),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        child: TextField(
                          controller: surnameController,
                          decoration: InputDecoration(
                              labelText: 'Cognome',
                              border: OutlineInputBorder()),
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
                        labelText: 'E-mail', border: OutlineInputBorder()),
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
                              obscurePassword
                                  ? obscurePassword = false
                                  : obscurePassword = true;
                            });
                          },
                          icon: (obscurePassword)
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        )),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                FlatButton(
                  onPressed: () async {
                    bool registered = await userApi.registerUser(User(
                        name: nameController.text,
                        surname: surnameController.text,
                        email: emailController.text,
                        password:
                            userApi.sha256Encrypt(passwordController.text)));

                    if (registered) {
                      Navigator.pushReplacementNamed(context, '/');
                    } else {
                      showDialog(
                          context: null,
                          builder: (_) => MyAlertDialog(
                              content: 'Registrazione non riuscita!'));
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
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          child: Text('Accedi'))
                    ])),
                Blob.animatedFromID(
                  size: 150,
                  id: [
                    '13-5-481',
                    '13-5-98',
                    '13-5-11429',
                    '13-5-62',
                    '14-4-9005'
                  ],
                  duration: Duration(milliseconds: 1500),
                  styles: BlobStyles(
                    gradient: LinearGradient(colors: [
                      Colors.blueAccent.withOpacity(0.2),
                      Colors.blue.withOpacity(0.4),
                    ]).createShader(Rect.fromLTRB(0, 100, 200, 300)),
                  ),
                  loop: true,
                )
              ]),
            )),
      ),
    ));
  }
}
