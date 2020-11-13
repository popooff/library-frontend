import 'package:flutter/material.dart';
import 'package:library_frontend/models/book.dart';
import 'package:library_frontend/services/rest_api/book_api.dart';
import 'package:library_frontend/views/book_description.dart';


class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var searching;
  BookApi bookApi;
  List<Book> officialBooks = [];
  List<Book> booksForFilter = [];


  @override
  void initState() {
    searching = TextEditingController();
    bookApi = BookApi();
    getBooks();
    super.initState();
  }

  void getBooks() async {
    List<Book> _books = await bookApi.getBooks() ?? [];

    setState(() {
      officialBooks = _books;
    });
  }

  @override
  void dispose() {
    searching.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Column(
              children: [

                Container(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.search)
                    ),
                    onChanged: (value) {
                      setState(() {
                        booksForFilter = officialBooks.where((element) =>
                          (element.title.toLowerCase().contains(value.toLowerCase())
                              || element.author.toString().toLowerCase().contains(value.toLowerCase()))
                        ).toList();
                      });
                    },
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: booksForFilter.length,
                      itemBuilder: (context, index) {

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.black.withOpacity(0.3))
                          ),

                          child: ListTile(
                            title: Text(
                              '${booksForFilter[index].title}',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            subtitle: Text(
                              '${booksForFilter[index].author}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => BookDescription(book: booksForFilter[index]))
                              );
                            },
                          ),
                        );
                      }),
                )
              ])
        )
    );
  }

}
