import 'package:shared_preferences/shared_preferences.dart';


class Utils {

  final String urlServer = 'http://progettopawm.ns0.it:8090/api';
  SharedPreferences sharedPreferences;
  String token;

  Map<String, String> header /*(Future<dynamic> _token) async*/ = {
    // token = await _token;

    // Map map = {
      'Accept' : 'application/json',
      // 'Authorization' : token
    // };

    // return map;
  };


  Future<String> getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('token');
  }

  Future<void> setToken(String token) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
  }


  Future<int> getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('id');
  }

  Future<void> setUserId(int id) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('id', id);
  }


  Future<List<String>> getUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList('user');
  }

  Future<void> setUser(String name, String surname, String email) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('user', [name, surname, email]);
  }

}
