import 'package:shared_preferences/shared_preferences.dart';


class Utils {

  final String urlServer = 'http://82.84.32.209:8090/api';

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


  Future<String> getToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('token');
  }

  Future<void> setToken(String token) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
