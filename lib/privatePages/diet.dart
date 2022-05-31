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
  List<charts.Series<Sales, int>> _seriesLineData = [];
  final _formKey = GlobalKey<FormState>();
  final glucoseController = new TextEditingController();
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
      new Sales(0, 125),
      new Sales(1, 125),
      new Sales(2, 125),
      new Sales(3, 125),
      new Sales(4, 125),
      new Sales(5, 125),
    ];
    var linesalesdata2 = [
      new Sales(0, 100),
      new Sales(1, 100),
      new Sales(2, 100),
      new Sales(3, 100),
      new Sales(4, 100),
      new Sales(5, 100),
    ];

    var linesalesdata3 = [
      new Sales(0, 70),
      new Sales(1, 70),
      new Sales(2, 70),
      new Sales(3, 70),
      new Sales(4, 70),
      new Sales(5, 70),
    ];
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.blueAccent),
        id: 'Constant',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color.fromARGB(255, 223, 168, 50)),
        id: 'Constant1',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color.fromARGB(255, 70, 223, 50)),
        id: 'Constant2',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color.fromARGB(255, 70, 223, 50)),
        id: 'Constant3',
        data: linesalesdata3,
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
    
    final glucoseField = TextField(
      autofocus: false,
      controller: glucoseController,
      keyboardType: TextInputType.name,
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

    final submitButton =  Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF84BDCE),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
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
                Tab(icon: Icon(FontAwesomeIcons.crutch),),
                Tab(icon: Icon(FontAwesomeIcons.chartLine),),
              ]),
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
                                    height: 300,
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
                          child: charts.LineChart(_seriesLineData,
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

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
