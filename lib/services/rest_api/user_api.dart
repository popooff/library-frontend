import 'package:library_frontend/services/utils.dart';
import 'package:http/http.dart' as http;
import 'package:crypt/crypt.dart';
import '../../models/user.dart';
import 'dart:convert';


class UserApi extends Utils {

  Future<List<dynamic>> loginUser(User user) async {
    var response = await http.post(
        '$urlServer/authentication/userLogin',
        headers: header,
        body: user.loginJson()
    );

    var jsonResponse = jsonDecode(response.body);

    List<dynamic> list = [];
    list.add(response.statusCode == 200);
    list.add(jsonResponse['data']['ID']);
    list.add(jsonResponse['data']['Nome']);
    list.add(jsonResponse['data']['Cognome']);
    list.add(jsonResponse['data']['Email']);
    list.add(jsonResponse['data']['jwt']);
    setCredential(list);

    return list;
  }


  Future<bool> registerUser(User user) async {

    var response = await http.post(
        '$urlServer/authentication/addUser',
        headers: header,
        body: user.registrationJson()
    );

    return response.statusCode == 201;
  }


  void setCredential(List<dynamic> list) {
    setUserId(list[1]);
    setUser(list[2], list[3], list[4]);
    setToken(list[5]);
  }


  // $5$rounds=10000$abcdefghijklmnop$51muKIziT9VAyDZ2ZueAYvAwgIYx0cLxUCIAlPoWaHD
  // 51muKIziT9VAyDZ2ZueAYvAwgIYx0cLxUCIAlPoWaHD
  String sha256Encrypt(String password) {
    return Crypt.sha256(password, rounds: 12831, salt: 'good_game_man')
        .toString()
        .substring(30);
  }

}
