
class Reservation {

  final int idUser;
  final int idBook;
  final DateTime dateReservation;

  Reservation(
    this.idUser,
    this.idBook,
    this.dateReservation
  );


  Map<String, dynamic> toJson() => {
    'utente': idUser,
    'libro': idBook,
    'dataPrenotazione': dateReservation
  };

}
