import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:library_frontend/models/chart.dart';
import 'package:library_frontend/services/rest_api/chart_api.dart';
import 'package:library_frontend/widgets/chart_text_indicator.dart';
import 'dart:math';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int touchedIndex;
  ChartApi chartApi;

  @override
  void initState() {
    chartApi = ChartApi();
    super.initState();
  }

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
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text(
              'Dashboard',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20)),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Profile')),
                ],
                rows: [
                  DataRow(selected: true, cells: [
                    DataCell(
                      Text('Nome'), /*showEditIcon: true*/
                    ),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(
                      Text('Cognome'), /*showEditIcon: true*/
                    ),
                  ]),
                  DataRow(selected: true, cells: [
                    DataCell(
                      Text('Email'), /*showEditIcon: true*/
                    ),
                  ]),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                Icon(Icons.settings),
                SizedBox(
                  width: 10,
                ),
                Text('Modifica dati profilo')
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 6, right: 6),
            child: Container(
                child: FutureBuilder(
              future: chartApi.getAllKindUserRead(chartApi.getUserId()),
              builder: (context, AsyncSnapshot<List<Chart>> data) {
                if (data.data == null || data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var list = data.data ?? [];
                  return AspectRatio(
                    aspectRatio: 1.5,
                    child: Card(
                      color: Colors.white,
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 18,
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 30,
                                  sections: List.generate(list.length, (i) {
                                    return PieChartSectionData(
                                      color: kindColor[list[i].kind],
                                      value: list[i].bookNumber.toDouble(),
                                      title: '${list[i].bookNumber}',
                                      radius: 55,
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int count = 0;
                                  count < list.length ?? 0;
                                  count++)
                                Padding(
                                  padding: EdgeInsets.only(top: 1, bottom: 1),
                                  child: ChartTextIndicator(
                                    backgroundColor:
                                        kindColor['${list[count].kind}'],
                                    text: '${list[count].kind}',
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: LineChartSample2(),
          )
        ],
      ),
    ));
  }
}

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  ChartApi chartApi;

  @override
  void initState() {
    chartApi = ChartApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Colors.black),
            child: Padding(
                padding: const EdgeInsets.only(
                    right: 20.0, left: 20.0, top: 25, bottom: 10),
                child: FutureBuilder(
                  future: chartApi.getAllMonthUserRead(),
                  builder: (context, AsyncSnapshot<List<Chart>> data) {
                    if (data.data == null || data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      int maxY = data.data.map((e) => e.bookNumber).toList().reduce(max);

                      return LineChart(LineChartData(
                        // TODO fa vedere le griglie orizzontali e verticali
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          // TODO aumenta lo spessore delle linee, quindi quello regola
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              // TODO colore delle linee e spessore di essa
                              color: const Color(0xff37434d),
                              strokeWidth: 1,
                            );
                          },
                          getDrawingVerticalLine: (value) {
                            return FlLine(
                              color: const Color(0xff37434d),
                              strokeWidth: 1,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          // TODO tutto quello che riguarda le scritto sotto
                          bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            getTextStyles: (value) =>
                                // TODO posso cambiare colore delle lettere dei mesi
                                const TextStyle(
                                    color: Color(0xff68737d),
                                    /*fontWeight: FontWeight.bold,*/
                                    fontSize: 12),
                            getTitles: (value) {
                              switch (value.toInt()) {
                                case 0:
                                  return 'Gen';
                                case 1:
                                  return 'Feb';
                                case 2:
                                  return 'Mar';
                                case 3:
                                  return 'Apr';
                                case 4:
                                  return 'Mar';
                                case 5:
                                  return 'Giu';
                                case 6:
                                  return 'Lug';
                                case 7:
                                  return 'Ago';
                                case 8:
                                  return 'Set';
                                case 9:
                                  return 'Ott';
                                case 10:
                                  return 'Nov';
                                case 11:
                                  return 'Dic';
                              }
                              return '';
                            },
                            margin: 5,
                          ),
                          // TODO scritte a sinistra
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (value) => const TextStyle(
                              color: Color(0xff67727d),
                              fontSize: 13,
                            ),
                            getTitles: (value) {
                              switch (value.toInt()) {
                                case 3:
                                  return '3';
                                case 6:
                                  return '6';
                                case 9:
                                  return '9';
                              }
                              return '';
                            },
                            reservedSize: 5,
                            margin: 8,
                          ),
                        ),

                        // TODO bordo intorno al grafico, piu fico senza
                        borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                                color: const Color(0xff37434d), width: 1)),
                        minX: 1,
                        maxX: 12,
                        minY: 0,
                        maxY: maxY.toDouble(),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              for (int x = 0; x < data.data.length; x++)
                                FlSpot(data.data[x].month.toDouble(),
                                    data.data[x].bookNumber.toDouble())
                            ],
                            isCurved: false,
                            colors: [Colors.black, Colors.pink],
                            // TODO spessore della barra
                            barWidth: 2,
                            isStrokeCapRound: true,
                            // TODO puntini della barra ad ogni mese
                            dotData: FlDotData(
                              show: true,
                            ),
                            // TODO colore sotto la barra che va a sfumare
                            belowBarData: BarAreaData(
                              show: true,
                              colors: gradientColors
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                            ),
                          ),
                        ],
                      ));
                    }
                  },
                )

                ),
          ),
        ),
      ],
    );
  }

}
