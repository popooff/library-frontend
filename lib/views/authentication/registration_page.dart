import 'package:flutter/material.dart';
import 'package:library_frontend/models/user.dart';
import 'package:library_frontend/services/rest_api/user_api.dart';
import 'package:library_frontend/widgets/my_alert.dart';


// TODO passare i dati da questa pagina a quella di login senza riscriverli.
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

          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              children: [

                Image.asset(
                  'assets/library_registration.png',
                  height: 280,
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
                  ],
                ),

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

                    bool registered = await userApi.registerUser(
                      User(
                        name: nameController.text,
                        surname: surnameController.text,
                        email: emailController.text,
                        password: userApi.sha256Encrypt(passwordController.text)
                      )
                    );

                    if (registered) {
                      Navigator.pushReplacementNamed(context, '/');

                    } else {
                      showDialog(
                          context: null,
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
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: Text('Accedi')
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
