// ignore_for_file: use_full_hex_values_for_flutter_colors, unused_field, deprecated_member_use, prefer_collection_literals, prefer_const_constructors, non_constant_identifier_names, unnecessary_new, annotate_overrides, avoid_unnecessary_containers, avoid_types_as_parameter_names, prefer_const_constructors_in_immutables, prefer_final_fields
//import 'package:diabetes_assistant/model/user.dart';
//import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:diabetes_assistant/privatePages/home.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DietPage extends StatefulWidget {
  final Widget child;

  DietPage({Key? key, required this.child}) : super(key: key);

  _DietPageState createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  List<charts.Series<Sales, int>> _seriesLineData = [];
  _generateData() {

    var linesalesdata = [
      new Sales(0, 85),
      new Sales(1, 95),
      new Sales(2, 80),
      new Sales(3, 110),
      new Sales(4, 78),
      new Sales(5, 92),
    ];
    var linesalesdata1 = [
      new Sales(0, 100),
      new Sales(1, 100),
      new Sales(2, 100),
      new Sales(3, 100),
      new Sales(4, 100),
      new Sales(5, 100),
    ];

    var linesalesdata2 = [
      new Sales(0, 60),
      new Sales(1, 60),
      new Sales(2, 60),
      new Sales(3, 60),
      new Sales(4, 60),
      new Sales(5, 60),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Constant',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Constant1',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Constant2',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Glicemia'),
            backgroundColor: const Color(0xFF8215466),
          ),
          drawer: const NavigationDrawer(),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Glicemia diaria',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.LineChart(_seriesLineData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: false, stacked: false),
                              animate: true,
                              animationDuration: Duration(seconds: 5),
                              behaviors: [
                                new charts.ChartTitle('Days',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Glicemia(mg/dL)',
                                    behaviorPosition:
                                        charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
