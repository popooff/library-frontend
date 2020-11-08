import 'dart:convert';

import 'package:crypt/crypt.dart';
import 'package:http/http.dart' as http;
import 'package:library_frontend/services/utils.dart';

import '../../models/user.dart';

class UserApi extends Utils {
  Future<bool> loginUser(User user) async {
    var response = await http.post('$urlServer/authentication/userLogin',
        headers: header, body: user.loginJson());

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['data'] is List) {
      var id = jsonResponse['data'][0]['ID'];
      var name = jsonResponse['data'][0]['Nome'];
      var surname = jsonResponse['data'][0]['Cognome'];
      var email = jsonResponse['data'][0]['Email'];
      setCredential(id, name, surname, email);
    } else {
      var id = jsonResponse['data']['ID'];
      var name = jsonResponse['data']['Nome'];
      var surname = jsonResponse['data']['Cognome'];
      var email = jsonResponse['data']['Email'];
      setCredential(id, name, surname, email);
    }

    return (response.statusCode == 200) ? true : false;
  }

  Future<bool> registerUser(User user) async {
    var response = await http.post('$urlServer/authentication/addUser',
        headers: header, body: user.registrationJson());

    return (response.statusCode == 201) ? true : false;
  }

  void setCredential(int id, String name, String surname, String email) {
    setUserId(id);
    setUser(name, surname, email);
  }

  // $5$rounds=10000$abcdefghijklmnop$51muKIziT9VAyDZ2ZueAYvAwgIYx0cLxUCIAlPoWaHD
  // 51muKIziT9VAyDZ2ZueAYvAwgIYx0cLxUCIAlPoWaHD
  String sha256Encrypt(String password) {
    return Crypt.sha256(password, rounds: 12831, salt: 'good_game_man')
        .toString()
        .substring(30);
  }
}
