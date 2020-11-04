import 'package:library_frontend/services/utils.dart';
import 'package:http/http.dart' as http;
import 'package:crypt/crypt.dart';
import '../../models/user.dart';
import 'dart:convert';


class UserApi extends Utils {

  Future<bool> loginUser(User user) async {

    var response = await http.post(
        '$urlServer/authentication/userLogin',
        headers: header,
        body: user.loginJson()
    );

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['data'] is List) {
      setUserId(jsonDecode(response.body)['data'][0]['ID']);

    } else {
      setUserId(jsonDecode(response.body)['data']['ID']);
    }

    return (response.statusCode == 200) ? true : false;
  }


  Future<bool> registerUser(User user) async {

    var response = await http.post(
        '$urlServer/authentication/addUser',
        headers: header,
        body: user.registrationJson()
    );

    return (response.statusCode == 201) ? true : false;
  }


  // $5$rounds=10000$abcdefghijklmnop$51muKIziT9VAyDZ2ZueAYvAwgIYx0cLxUCIAlPoWaHD
  // 51muKIziT9VAyDZ2ZueAYvAwgIYx0cLxUCIAlPoWaHD
  String sha256Encrypt(String password) {
    return Crypt.sha256(password, rounds: 12831, salt: 'good_game_man')
        .toString()
        .substring(30);
  }

}
