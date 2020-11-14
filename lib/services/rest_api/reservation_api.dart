import 'package:library_frontend/models/reservation.dart';
import 'package:library_frontend/services/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book_api.dart';


class ReservationApi extends Utils {

  BookApi bookApi = BookApi();
  Reservation reservation;
  int idUser;


  Future<bool> addReservation(Future<int> userId, int idBook) async {
    idUser = await userId;
    reservation = Reservation(
        idUser: idUser,
        idBook: idBook,
        dateReservation: DateTime.parse(DateTime.now().toString().split(' ')[0])
    );

    var response = await http.post(
        '$urlServer/prenotazioni/addPrenotazione',
        headers: header,
        body: reservation.bookedJson()
    );

    return (response.statusCode == 200) ? true : false;
  }


  Future<bool> returnBook(int idReservation) async {
    reservation = Reservation(
        dateReturned: DateTime.parse(DateTime.now().toString().split(' ')[0])
    );

    var response = await http.put(
        '$urlServer/prenotazioni/returnBook/$idReservation',
        headers: header,
        body: reservation.returnedJson()
    );

    return (response.statusCode == 200) ? true : false;
  }


  Future<List<Reservation>> getAllBooksReservation(Future<int> userId) async {
    idUser = await userId;
    var response = await http.get(
        '$urlServer/prenotazioni/getBookPrenotations/$idUser',
        headers: header
    );

    List<Reservation> list = [];
    for (var el in jsonDecode(response.body)['data'][0]) {

      var book = await bookApi.getBookById(el['ID']);

      list.add(
          Reservation(
              book: book,
              bookedDatesForTheSameBook: el['Prenotazioni']
                  .toString()
                  .split(',')
                  .map((e) => DateTime.parse(e))
                  .toList()
          )
      );
    }

    return list;
  }


  Future<List<Reservation>> getBooksToBeReturned(Future<int> userId) async {
    idUser = await userId;
    var response = await http.get(
        '$urlServer/prenotazioni/daRestituire/$idUser',
        headers: header
    );

    List<Reservation> list = [];
    for (var el in jsonDecode(response.body)['data'][0]) {

      var book = await bookApi.getBookById(el['Libro']);

      list.add(
        Reservation(
          book: book,
          idReservation: el['ID'],
          dateReservation: DateTime.parse(el['DataPrenotazione'].toString().substring(0, 10))
        )
      );
    }

    return list;
  }

}
