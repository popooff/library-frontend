import 'package:http/http.dart' as http;
import 'package:library_frontend/services/utils.dart';
import '../../models/book.dart';
import 'dart:convert';


class BookApi extends Utils {


  Future<List<Book>> getBooks() async {
    var response = await http.get(
        '$urlServer/libri/getAll',
        headers: header
    );

    return List
        .from(jsonDecode(response.body)['data'][0])
        .map((e) => Book.fromJson(e))
        .toList();
  }

}
