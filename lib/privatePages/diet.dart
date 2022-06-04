// ignore_for_file: use_full_hex_values_for_flutter_colors, unused_field, deprecated_member_use, prefer_collection_literals, prefer_const_constructors, non_constant_identifier_names, unnecessary_new, annotate_overrides, avoid_unnecessary_containers, avoid_types_as_parameter_names, prefer_const_constructors_in_immutables, prefer_final_fields
//import 'package:diabetes_assistant/model/user.dart';
//import 'package:diabetes_assistant/utils/userPreferences.dart';
import 'package:diabetes_assistant/widget/navigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DietPage extends StatefulWidget {
  final Widget child;

  DietPage({Key? key, required this.child}) : super(key: key);

  _DietPageState createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  List<charts.Series<GlucoseTest, DateTime>> _seriesLineData = [];
  final _formKey = GlobalKey<FormState>();
  final glucoseController = new TextEditingController();
  var glucoseData = [
    new GlucoseTest(DateTime.now().subtract(Duration(days: 6)), 85),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 5)), 95),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 4)), 80),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 3)), 110),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 2)), 78),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 1)), 92),
  ];
  var line1 = [
    new GlucoseTest(DateTime.now().subtract(Duration(days: 6)), 125),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 5)), 125),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 4)), 125),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 3)), 125),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 2)), 125),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 1)), 125),
  ];
  var line2 = [
    new GlucoseTest(DateTime.now().subtract(Duration(days: 6)), 100),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 5)), 100),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 4)), 100),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 3)), 100),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 2)), 100),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 1)), 100),
  ];
  var line3 = [
    new GlucoseTest(DateTime.now().subtract(Duration(days: 6)), 70),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 5)), 70),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 4)), 70),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 3)), 70),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 2)), 70),
    new GlucoseTest(DateTime.now().subtract(Duration(days: 1)), 70),
  ];
  _generateData() {
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.blueAccent),
        id: 'Constant',
        data: glucoseData,
        domainFn: (GlucoseTest test, _) => test.date,
        measureFn: (GlucoseTest test, _) => test.value,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 223, 168, 50)),
        id: 'Constant1',
        data: line1,
        domainFn: (GlucoseTest test, _) => test.date,
        measureFn: (GlucoseTest test, _) => test.value,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 70, 223, 50)),
        id: 'Constant2',
        data: line2,
        domainFn: (GlucoseTest test, _) => test.date,
        measureFn: (GlucoseTest test, _) => test.value,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 70, 223, 50)),
        id: 'Constant3',
        data: line3,
        domainFn: (GlucoseTest test, _) => test.date,
        measureFn: (GlucoseTest test, _) => test.value,
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
    final glucoseField = TextField(
      autofocus: false,
      controller: glucoseController,
      keyboardType: TextInputType.number,
      onSubmitted: (value) {
        glucoseController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(FontAwesomeIcons.crutch),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Glucemia value',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF84BDCE),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          int? glucose = int.tryParse(glucoseController.text);
          if (glucose == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Este valor no es un número válido.",
                  style: TextStyle(fontSize: 16)),
            ));
          } else {
            setState(() {
              glucoseData.add(GlucoseTest(DateTime.now(), glucose));
              line1.add(GlucoseTest(DateTime.now(), 125));
              line2.add(GlucoseTest(DateTime.now(), 100));
              line3.add(GlucoseTest(DateTime.now(), 70));
            });
            glucoseController.text = "";
          }
        },
        child: Text(
          'Añadir',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Glucemia'),
            backgroundColor: const Color(0xFF8215466),
            bottom: TabBar(
              indicatorColor: Color(0xFF84BDCE),
              tabs: const [
                Tab(icon: Icon(FontAwesomeIcons.crutch)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
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
                          'Niveles de glucemia',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 200,
                                    child: Image.asset(
                                      'assets/big_logo.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 45),
                                  glucoseField,
                                  SizedBox(height: 20),
                                  SizedBox(height: 45),
                                  submitButton,
                                  SizedBox(height: 15),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Reportes de glucosa',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.TimeSeriesChart(_seriesLineData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: false, stacked: false),
                              animate: true,
                              animationDuration: Duration(seconds: 2),
                              behaviors: [
                                new charts.ChartTitle('Dias',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Glucemia(mg/dL)',
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

class GlucoseTest {
  DateTime date;
  int value;

  GlucoseTest(this.date, this.value);
}
