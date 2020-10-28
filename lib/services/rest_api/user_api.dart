import 'package:library_frontend/services/utils.dart';
import 'package:http/http.dart' as http;
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

}
