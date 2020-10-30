
class Reservation {

  final int idUser;
  final int idBook;
  final int idReservation;
  final DateTime dateReservation;
  final DateTime dateReturned;

  Reservation({
    this.idUser,
    this.idBook,
    this.idReservation,
    this.dateReservation,
    this.dateReturned
  });


  Map<String, dynamic> bookedJson() => {
    'utente': idUser,
    'libro': idBook,
    'dataPrenotazione': dateReservation.toString()
  };

  Map<String, dynamic> returnedJson() => {
    'idPrenotazione': idReservation,
    'dataRestituzione': dateReturned.toString()
  };

}
