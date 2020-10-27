import 'package:meta/meta.dart';


class User {

  final String name;
  final String surname;
  final String email;
  final String password;

  User({
    this.name,
    this.surname,
    @required this.email,
    @required this.password
  });

  /*
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password']
    );
  }
   */

  Map<String, String> registrationJson() => {
    'nome': name,
    'cognome': surname,
    'email': email,
    'password': password
  };

  Map<String, String> loginJson() => {
    'email': email,
    'password': password
  };

}
