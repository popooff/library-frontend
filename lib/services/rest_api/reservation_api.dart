import 'package:library_frontend/services/utils.dart';
import 'package:http/http.dart' as http;


class ReservationApi extends Utils {

  int idUser;


  Future<bool> addReservation(Future<int> userId, int idBook) async {
    idUser = await userId;

    var response = await http.post(
        '$urlServer/prenotazioni/addPrenotazione',
        headers: header,
        body: {
          'utente': '$idUser',
          'libro': '$idBook',
          'dataPrenotazione': DateTime.now().toString().split(' ')[0]
        }
    );

    return (response.statusCode == 200) ? true : false;
  }


  Future<bool> addReturned(Future<int> userId, int idBook) async {
    idUser = await userId;

    var response = await http.put(
        '$urlServer/prenotazioni/returnBook',
        headers: header,
        body: {
          'utente': '$idUser',
          'libro': '$idBook',
          'dataRestituzione': DateTime.now().toString().split(' ')[0]
        }
    );

    return (response.statusCode == 200) ? true : false;
  }

}
