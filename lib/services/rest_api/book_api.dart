import 'package:http/http.dart' as http;
import 'package:library_frontend/services/utils.dart';
import '../../models/book.dart';
import 'dart:convert';


class BookApi extends Utils {

  String token;

  Future<List<Book>> getBooks() async {
    token = await getToken();
    var response = await http.get(
        '$urlServer/libri/getAll',
        headers: authHeader(token)
    );

    return List
        .from(jsonDecode(response.body)['data'][0])
        .map((e) => Book.fromJson(e))
        .toList();
  }


  Future<List<Book>> getBook(int start, int end) async {
    token = await getToken();
    var response = await http.get(
        '$urlServer/libri/getAll2?limit1=$start&limit2=$end',
        headers: authHeader(token)
    );

    return List.from(jsonDecode(response.body)['data'][0])
        .map((e) => Book.fromJson(e))
        .toList();
  }


  Future<List<Book>> searchBooks(String query) async {
    token = await getToken();
    var response = await http.get(
        '$urlServer/libri/cercaLibro/$query',
        headers: authHeader(token)
    );

    return List.from(jsonDecode(response.body)['data'][0])
        .map((e) => Book.fromJson(e))
        .toList();
  }

}
