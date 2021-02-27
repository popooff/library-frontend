import 'book.dart';


class Reservation {

  final int idUser;
  final int idBook;
  final int idReservation;
  final Book book;
  final DateTime dateReservation;
  final DateTime dateReturned;

  bool returned = false;
  bool loading = false;


  // Usata solo per inglobare le date per la pagina dei libri prenotati.
  final List<DateTime> bookedDatesForTheSameBook;

  Reservation({
    this.idUser,
    this.idBook,
    this.idReservation,
    this.book,
    this.dateReservation,
    this.dateReturned,
    this.bookedDatesForTheSameBook
  });


  Map<String, dynamic> bookedJson() => {
    'utente': '$idUser',
    'libro': '$idBook',
    'dataPrenotazione': dateReservation.toString()
  };

  Map<String, dynamic> returnedJson() => {
    'dataRestituzione': dateReturned.toString()
  };


  String getBookedDates() {
    String dates = '';
    bookedDatesForTheSameBook.forEach((element) {
      dates += '- ${element.toString().substring(0, 10)}\n';
    });

    return dates;
  }
}
