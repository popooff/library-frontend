import 'package:library_frontend/models/reservation.dart';
import 'package:library_frontend/services/utils.dart';
import 'package:library_frontend/models/book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ReservationApi extends Utils {

  Reservation reservation;
  int idUser;
  String token;


  Future<bool> addReservation(Future<int> userId, int idBook) async {
    idUser = await userId;
    token = await getToken();
    reservation = Reservation(
        idUser: idUser,
        idBook: idBook,
        dateReservation: DateTime.parse(DateTime.now().toString().split(' ')[0])
    );

    var response = await http.post(
        '$urlServer/prenotazioni/addPrenotazione',
        headers: authHeader(token),
        body: reservation.bookedJson()
    );

    return (response.statusCode == 200) ? true : false;
  }


  Future<bool> returnBook(int idReservation) async {
    token = await getToken();
    reservation = Reservation(
        dateReturned: DateTime.parse(DateTime.now().toString().split(' ')[0])
    );

    var response = await http.put(
        '$urlServer/prenotazioni/returnBook/$idReservation',
        headers: authHeader(token),
        body: reservation.returnedJson()
    );

    return (response.statusCode == 200) ? true : false;
  }


  Future<List<Reservation>> getAllBooksReservation(Future<int> userId) async {
    idUser = await userId;
    token = await getToken();
    var response = await http.get(
        '$urlServer/prenotazioni/getBookPrenotations/$idUser',
        headers: authHeader(token)
    );

    List<Reservation> list = [];
    for (var el in jsonDecode(response.body)['data'][0]) {

      list.add(
          Reservation(
              book: Book.reserved(el),
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
    token = await getToken();
    var response = await http.get(
        '$urlServer/prenotazioni/daRestituire/$idUser',
        headers: authHeader(token)
    );

    List<Reservation> list = [];
    for (var el in jsonDecode(response.body)['data'][0]) {

      list.add(
        Reservation(
          book: Book.toReturn(el),
          idReservation: el['ID'],
        )
      );
    }

    return list;
  }

}
