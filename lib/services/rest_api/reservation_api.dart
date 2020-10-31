import 'package:library_frontend/models/reservation.dart';
import 'package:library_frontend/services/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book_api.dart';


class ReservationApi extends Utils {

  int idUser;
  Reservation reservation;
  List<Reservation> list = [];
  BookApi bookApi;


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


  Future<bool> addReturned(int idReservation, int idBook) async {
    reservation = Reservation(
        idReservation: idReservation,
        dateReturned: DateTime.parse(DateTime.now().toString().split(' ')[0])
    );

    var response = await http.put(
        '$urlServer/prenotazioni/returnBook',
        headers: header,
        body: reservation.returnedJson()
    );

    return (response.statusCode == 200) ? true : false;
  }


  Future<List<Reservation>> getUserReservation(Future<int> userId) async {
    idUser = await userId;
    var response = await http.get(
        '$urlServer/prenotazioni/libriUtente/$idUser',
        headers: header
    );

    return null;
  }


  Future<List<Reservation>> getUserToBeReturned(Future<int> userId) async {
    idUser = await userId;
    var response = await http.get(
        '$urlServer/prenotazioni/daRestituire/$idUser',
        headers: header
    );

    var responseList = jsonDecode(response.body)['data'][0];

    for (var el in responseList) {
      list.add(
        Reservation(
          idBook: el['Libro'],
          idReservation: el['ID'],
          dateReservation: DateTime.parse(el['DataPrenotazione'].toString().substring(0, 10))
        )
      );
    }

    for (var el in list) {
      print(el.idBook);
    }

    return null;
  }
// {"Libro":36,"DataPrenotazione":"2020-10-26T00:00:00.000Z","ID":24}
//   Id libro                                                 Id prenotazione

}
