import 'package:http/http.dart' as http;
import 'package:library_frontend/services/utils.dart';
import '../../models/book.dart';
import 'dart:convert';


class BookApi extends Utils {

  int idUser;


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


  Future<List<Book>> getUserReservationBooks(Future<int> userId) async {
    idUser = await userId;
    var response = await http.get(
        '$urlServer/prenotazioni/libriUtente/$idUser',
        headers: header
    );

    return List
        .from(jsonDecode(response.body)['data'][0])
        .map((e) => Book.fromJson(e))
        .toList();
  }


  Future<List<Book>> getUserToBeReturnedBooks(Future<int> userId) async {
    idUser = await userId;
    var response = await http.get(
        '$urlServer/prenotazioni/daRestituire/$idUser',
        headers: header
    );

    return List
        .from(jsonDecode(response.body)['data'][0])
        .map((e) => Book.fromJson(e))
        .toList();
  }


  Future<Book> getBookById(int id) async {
    var response = await http.get(
        '$urlServer/libri/getBook/$id',
        headers: header
    );

    return Book.fromJson(jsonDecode(response.body)['data'][0][0]);
  }

}
