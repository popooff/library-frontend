import 'package:library_frontend/models/reservation.dart';
import 'package:library_frontend/services/utils.dart';
import 'package:http/http.dart' as http;


class ReservationApi extends Utils {

  int idUser;
  Reservation reservation;


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

}
