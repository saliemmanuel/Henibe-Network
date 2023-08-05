import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  final String ordoneeLabel;
  final int value;

  const Chart({super.key, required this.ordoneeLabel, required this.value});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<LiveData> chartData;

  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 3), updateDataSource);
    super.initState();
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, widget.value));
    chartData.removeAt(0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, -80),
      LiveData(1, -82),
      LiveData(2, -83),
      LiveData(3, -67),
      LiveData(4, -78),
      LiveData(5, -80),
      LiveData(6, -76),
      LiveData(7, -75),
      LiveData(8, -50),
      LiveData(9, -85),
      LiveData(10, -80),
      LiveData(11, -75),
      LiveData(12, -81),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SfCartesianChart(
                series: <LineSeries<LiveData, int>>[
          LineSeries<LiveData, int>(
            dataSource: chartData,
            color: const Color.fromRGBO(192, 108, 132, 1),
            xValueMapper: (LiveData sales, _) => sales.time,
            yValueMapper: (LiveData sales, _) => sales.speed,
          )
        ],
                primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                    title: AxisTitle(text: 'Temps(seconds)')),
                primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: widget.ordoneeLabel)))));
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
