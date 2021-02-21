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


  Future<Book> getBookById(int id) async {
    token = await getToken();
    var response = await http.get(
        '$urlServer/libri/getBook/$id',
        headers: authHeader(token)
    );

    return Book.fromJson(jsonDecode(response.body)['data'][0][0]);
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

}
