
class Chart {

  final int bookNumber;
  final String kind;
  final int month;

  Chart({
    this.bookNumber,
    this.kind,
    this.month
  });


  factory Chart.kindChart(Map<String, dynamic> json) {
    return Chart(
      bookNumber: json['NumeroLibri'],
      kind: json['Descrizione']
    );
  }

  factory Chart.monthChart(int numberBook, int month) {
    return Chart(
        bookNumber: numberBook,
        month: month
    );
  }

}
