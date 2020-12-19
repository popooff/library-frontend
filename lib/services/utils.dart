import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Utils {

  final String urlServer = 'http://progettopawm.ns0.it:8090/api';

  Map<String, String> authHeader(String token) {
    Map<String, String> map = {
      'Accept': 'application/json',
      'Authorization': token
    };

    return map;
  }

  Map<String, String> header = {
    'Accept': 'application/json'
  };


  Future<bool> isValid() async {
    String token = await getToken();
    bool valid = await isLog();
    var response = await http.get(
      '$urlServer/download/cappuccettorosso.jpg',
      headers: authHeader(token)
    );

    return response.statusCode == 401 && valid;
  }


  Future<String> getToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('token');
  }

  Future<void> setToken(String token) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    sharedPreferences.setString('token', token);
  }


  Future<int> getUserId() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('id');
  }

  Future<void> setUserId(int id) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('id', id);
  }


  Future<List<String>> getUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList('user');
  }

  Future<void> setUser(String name, String surname, String email) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('user', [name, surname, email]);
  }


  Future<bool> isLog() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isLogged');
  }

  Future<void> setLog(bool log) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLogged', log);
  }

  Future<void> logout() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLogged', false);
  }

}
