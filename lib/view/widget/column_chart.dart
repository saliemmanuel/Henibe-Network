import 'package:bheya_network_example/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../config/palette.dart';
import '../../widget/custom_text.dart';

class ColumnChart extends StatefulWidget {
  final Map map;
  final int sum;
  final double maximum;
  final String? label;
  final String? typeReseau;
  const ColumnChart(
      {super.key,
      required this.map,
      required this.sum,
      required this.maximum,
      required this.label,
      required this.typeReseau});

  @override
  State<ColumnChart> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(height: 20.0),
          CustomText(widget.typeReseau!,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Palette.primaryColor),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 300.0,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                  title: AxisTitle(
                      text: widget.label,
                      textStyle: const TextStyle(fontSize: 10.0))),
              primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: "Occurence (%)",
                      textStyle: const TextStyle(fontSize: 10.0)),
                  minimum: 0,
                  maximum: 100,
                  interval: 5),
              tooltipBehavior: _tooltip,
              series: <ChartSeries<dynamic, dynamic>>[
                for (var element in widget.map.keys)
                  ColumnSeries<dynamic, dynamic>(
                      dataSource: [widget.map],
                      xValueMapper: (datum, index) => "$element",
                      yValueMapper: (data, index) =>
                          (widget.map['$element'] / widget.sum) * 100,
                      dataLabelSettings: const DataLabelSettings(
                          color: Colors.black,
                          useSeriesColor: true,
                          isVisible: true,
                          opacity: 0.3),
                      color: const Color.fromRGBO(8, 142, 255, 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
