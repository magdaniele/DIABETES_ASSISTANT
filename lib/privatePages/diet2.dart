// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_new, use_key_in_widget_constructors
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DietPage extends StatelessWidget {
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;

  DietPage(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory DietPage.withSampleData() {
    return new DietPage(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: true, behaviors: [
      new charts.LinePointHighlighter(
          showHorizontalFollowLine:
              charts.LinePointHighlighterFollowLineType.none,
          showVerticalFollowLine:
              charts.LinePointHighlighterFollowLineType.nearest,),
      new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag),
    ],);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 80),
      new LinearSales(1, 95),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];
    final data1 = [
      new LinearSales(0, 60),
      new LinearSales(1, 60),
      new LinearSales(2, 60),
      new LinearSales(3, 60),
    ];
    final data2 = [
      new LinearSales(0, 120),
      new LinearSales(1, 120),
      new LinearSales(2, 120),
      new LinearSales(3, 120),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Sales1',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data1,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Sales2',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data2,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}