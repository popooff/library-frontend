import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:library_frontend/models/chart.dart';
import 'package:library_frontend/services/rest_api/chart_api.dart';
import 'package:library_frontend/services/rest_api/reservation_api.dart';
import 'package:library_frontend/views/booked_page.dart';
import 'package:library_frontend/views/returned_page.dart';
import 'package:library_frontend/widgets/not_found.dart';
import 'package:library_frontend/widgets/chart_text_indicator.dart';
import 'dart:math';


class Profile extends StatefulWidget {
  
  @override
  _ProfileState createState() => _ProfileState();
}

// TODO trovare il modo di stampare i dati dell'utente.
class _ProfileState extends State<Profile> {

  ChartApi chartApi;
  List<String> user = ['', '', ''];

  @override
  void initState() {
    chartApi = ChartApi();
    getCredential();
    super.initState();
  }

  void getCredential() async {
    user = await chartApi.getUser();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [

              SizedBox(
                height: 30,
              ),

              Center(
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Profile')),
                    ],
                    rows: [
                      DataRow(selected: true, cells: [
                        DataCell(Text('${user[0].toString()}')),
                      ]),

                      DataRow(selected: true, cells: [
                        DataCell(Text('${user[1].toString()}')),
                      ]),

                      DataRow(selected: true, cells: [
                        DataCell(Text('${user[2].toString()}')),
                      ]),
                    ]),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: BooksReservedReturned(true)
              ),

              SizedBox(
                height: 10,
              ),

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: BooksReservedReturned(false)
              ),

              SizedBox(
                height: 5,
              ),

              Padding(
                padding: EdgeInsets.only(left: 6, right: 6),
                child: CakeKindChart(chartApi)
              ),

              Padding(
                padding: EdgeInsets.all(10),
                child: LineMonthChart(),
              ),

              SizedBox(
                height: 30,
              )

            ]),
        )
    );
  }
}



class CakeKindChart extends StatefulWidget {

  final ChartApi chartApi;

  CakeKindChart(this.chartApi);

  @override
  _CakeKindChartState createState() => _CakeKindChartState();
}

class _CakeKindChartState extends State<CakeKindChart> {

  final Map<String, Color> kindColor = {
    'Autobografico': Colors.deepPurple,
    'Fantascienza': Colors.red,
    'Fantasy': Colors.pink,
    'Fiaba': Colors.yellow,
    'Horror': Colors.black,
    'Mystery': Colors.green,
    'Narrativo': Colors.deepOrangeAccent,
    'Romanzo': Colors.indigo,
    'Saggio': Colors.teal,
    'Thriller': Colors.brown,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
          future: widget.chartApi.getAllKindUserRead(widget.chartApi.getUserId()),
          builder: (context, AsyncSnapshot<List<Chart>> data) {
            if (data.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );

            } else {

              if (data.data != null && data.data.isEmpty) {
                return NotFound('Grafico dei generi più letti non disponibile!');
              }

              return AspectRatio(
                aspectRatio: 1.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black38)
                  ),
                  color: Colors.white,
                  child: Row(
                      children: [
                        const SizedBox(height: 18),

                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 2,
                                centerSpaceRadius: 30,
                                sections: List.generate(data.data.length, (i) {

                                  return PieChartSectionData(
                                    color: kindColor[data.data[i].kind],
                                    value: data.data[i].bookNumber.toDouble(),
                                    title: '${data.data[i].bookNumber}',
                                    radius: 55,
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),


                        SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                for (int count = 0; count < data.data.length; count++)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 1,
                                        bottom: 2
                                    ),
                                    child: ChartTextIndicator(
                                      backgroundColor: kindColor['${data.data[count].kind}'],
                                      text: '${data.data[count].kind}',
                                    ),
                                  ),
                              ]),
                        ),

                        const SizedBox(width: 10),
                      ]),
                ),
              );
            }
          },
        )
    );
  }
}



class LineMonthChart extends StatefulWidget {
  
  @override
  _LineMonthChartState createState() => _LineMonthChartState();
}

class _LineMonthChartState extends State<LineMonthChart> {

  ChartApi chartApi;

  @override
  void initState() {
    chartApi = ChartApi();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {

    return Container(
        child: FutureBuilder(
            future: chartApi.getAllMonthUserRead(),
            builder: (context, AsyncSnapshot<List<Chart>> data) {

              if (data.data == null) {
                return Center(child: CircularProgressIndicator());

              } else {

                if (data.data != null && data.data.isEmpty) {
                  return NotFound('Grafico delle prenotazioni mensili non\ndisponibile!');
                }

                int maxY = data.data.map((e) => e.bookNumber).toList().reduce(max);

                return Stack(
                    children: [
                      AspectRatio(
                          aspectRatio: 1.5,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Colors.white70,
                                  border: Border.all(color: Colors.black38)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 10,
                                    left: 15,
                                    top: 15,
                                    bottom: 5
                                ),

                                child: LineChart(LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: true,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                          color: Colors.black.withOpacity(0.5),
                                          strokeWidth: 0.5,
                                        );
                                      },
                                      getDrawingVerticalLine: (value) {
                                        return FlLine(
                                          color: Colors.black.withOpacity(0.5),
                                          strokeWidth: 0.5,
                                        );
                                      },
                                    ),

                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 20,
                                        getTextStyles: (value) => const TextStyle(
                                            color: Color(0xff68737d),
                                            fontSize: 11
                                        ),

                                        getTitles: (value) {
                                          switch (value.toInt()) {
                                            case 1:
                                              return 'Gen';
                                            case 2:
                                              return 'Feb';
                                            case 3:
                                              return 'Mar';
                                            case 4:
                                              return 'Apr';
                                            case 5:
                                              return 'Mar';
                                            case 6:
                                              return 'Giu';
                                            case 7:
                                              return 'Lug';
                                            case 8:
                                              return 'Ago';
                                            case 9:
                                              return 'Set';
                                            case 10:
                                              return 'Ott';
                                            case 11:
                                              return 'Nov';
                                            case 12:
                                              return 'Dic';
                                          }
                                          return '';
                                        },
                                        margin: 5,
                                      ),
                                      leftTitles: SideTitles(
                                        showTitles: true,
                                        getTextStyles: (value) => const TextStyle(
                                          color: Color(0xff67727d),
                                          fontSize: 11,
                                        ),
                                        getTitles: (value) {
                                          return '${value.toInt()}';
                                        },
                                        reservedSize: 5,
                                        margin: 8,
                                      ),
                                    ),

                                    borderData: FlBorderData(
                                        show: true,
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 0.5
                                        )
                                    ),

                                    minX: 1,
                                    maxX: 12,
                                    minY: 0,
                                    maxY: maxY.toDouble() + 1,

                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: [
                                          for (int x = 0; x < data.data.length; x++)
                                            FlSpot(
                                                data.data[x].month.toDouble(),
                                                data.data[x].bookNumber.toDouble()
                                            )
                                        ],

                                        isCurved: true,
                                        colors: [Colors.black38],
                                        barWidth: 1.5,
                                        isStrokeCapRound: true,
                                        dotData: FlDotData(
                                          show: true,
                                        ),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          colors: [Colors.blueAccent, Colors.blue, Colors.teal]
                                              .map((color) => color.withOpacity(0.3))
                                              .toList(),
                                        ),
                                      ),
                                    ])
                                ),
                              )
                          )
                      )
                    ]);
              }
            })
    );
  }

}



class BooksReservedReturned extends StatefulWidget {
  
  final bool or;
  BooksReservedReturned(this.or);

  @override
  _BooksReservedReturnedState createState() => _BooksReservedReturnedState();
}

class _BooksReservedReturnedState extends State<BooksReservedReturned> {

  ReservationApi reservationApi;


  @override
  void initState() {
    reservationApi = ReservationApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
            height: 250.0,
            child: FutureBuilder(
              future: widget.or ? reservationApi.getAllBooksReservation(reservationApi.getUserId()) :
                                  reservationApi.getBooksToBeReturned(reservationApi.getUserId()),
              builder: (context, data) {

                if (data.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                } else {

                  if (data.data != null && data.data.isEmpty) {
                    return NotFound(widget.or ? 'Nessun libro prenotato!' : 'Nessun libro da restituire!');
                  }

                  return Column(

                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Padding(
                            padding: EdgeInsets.only(left: 2),
                            child: Text(widget.or ? 'Libri prenotati' : 'Libri da restituire'),
                          ),

                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => widget.or ? BookedPage() : ReturnedPage(),
                                  settings: RouteSettings(
                                    arguments: data.data,
                                  ),
                                ),
                              );
                            },
                            child: Text('Vedi tutti'),
                          )
                        ],
                      ),

                      Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [

                              for (int index = 0; index < data.data.length / 3; index++)
                                Padding(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                  child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network('${reservationApi.urlServer}/download/${data.data[index].book.cover}'),
                                      )
                                  ),
                                )
                            ],
                          )
                      )
                    ],
                  );
                }
              },
            )
        )

      ],
    );
  }

}
