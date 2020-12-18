
class Book {

  int id;
  String title;
  String kind;
  List<String> author;
  String plot;
  String cover;
  int quantity;

  Book({
    this.id,
    this.title,
    this.kind,
    this.author,
    this.plot,
    this.cover,
    this.quantity
  });


  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['ID'],
      title: json['Titolo'],
      author: json['Autori'].toString().split(',').toList(),
      kind: json['Genere'],
      plot: json['Trama'],
      cover: json['Copertina'],
      quantity: json['Quantita'],
    );
  }

  String getAuthors() {
    return author.join(', ');
  }

}
