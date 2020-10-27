import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../../models/user.dart';
import '../../services/rest_api/user_api.dart';
import 'package:crypt/crypt.dart';


// $5$rounds=10000$abcdefghijklmnop$51muKIziT9VAyDZ2ZueAYvAwgIYx0cLxUCIAlPoWaHD
// 51muKIziT9VAyDZ2ZueAYvAwgIYx0cLxUCIAlPoWaHD
String sha256Encrypt(String password) {
  return Crypt.sha256(password, rounds: 12831, salt: 'good_game_man')
      .toString()
      .substring(30);
}


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  UserApi userApi;
  User user;


  @override
  void initState() {
    userApi = UserApi();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future<String> login(LoginData data) {
    return Future.delayed(Duration(milliseconds: 1000)).then((_) async {
      bool logged = await userApi.loginUser(
          User(
              email: data.name,
              password: sha256Encrypt(data.password)
          )
      );

      return logged ? null : 'Login fallito!';
    });
  }


  Future<String> register(LoginData data) {
    return Future.delayed(Duration(milliseconds: 1000)).then((_) async {
      user = User(
          name: '',
          surname: '',
          email: data.name,
          password: sha256Encrypt(data.password)
      );
      bool registered = await userApi.registerUser(user);

      return registered ? null : 'Registrazione fallita!';
    });
  }


  @override
  Widget build(BuildContext context) {

    return FlutterLogin(

      title: 'Library',
      logo: 'assets/library_logo1.jpg',
      onLogin: login,
      onSignup: register,

      onSubmitAnimationCompleted: () {
        Navigator.pushReplacementNamed(context, '/initial');
      },

      onRecoverPassword: (_) => Future(null),

      messages: LoginMessages(
        usernameHint: 'E-mail',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'Login',
        signupButton: 'Register',
        forgotPasswordButton: 'Forgot password?',
        recoverPasswordButton: 'Send mail',
        goBackButton: 'Back',
        confirmPasswordError: 'Le password non coincidono!',
        recoverPasswordDescription: 'Funzione non disponibile',
      ),

      theme: LoginTheme(
        primaryColor: Colors.white,
        accentColor: Colors.black,
        titleStyle: TextStyle(
          color: Colors.blue[300],
          letterSpacing: 1,
        ),

        cardTheme: CardTheme(
          color: Colors.blue[500],
          elevation: 5,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)),
        ),

        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.blue,
          errorStyle: TextStyle(
              color: Colors.white,
              decorationColor: Colors.blue
          ),
        ),

        buttonTheme: LoginButtonTheme(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );

  }
}
