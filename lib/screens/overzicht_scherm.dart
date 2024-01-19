import 'dart:async';

import 'package:brouw/services/http_service.dart';
import 'package:brouw/models/brouw_info.dart';
import 'package:brouw/widgets/rows/custom_data_row.dart';
import 'package:brouw/widgets/scaffolds/base_padding_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OverzichtScreen extends StatefulWidget {
  const OverzichtScreen({super.key});

  @override
  State<OverzichtScreen> createState() => _OverzichtScreenState();
}

class _OverzichtScreenState extends State<OverzichtScreen> {

  StreamSubscription<BrouwInfo>? _subscription;

  // Lists out of build method, as they will get rebuilt every time the build method is called
  final List<FlSpot> wortList = [];
  final List<FlSpot> pompList = [];
  final List<FlSpot> kleinList = [];
  final List<FlSpot> grootList = [];

  // FL Stuff
  FlBorderData borderData = FlBorderData(
    show: true,
    border: Border.all(
      color: const Color(0xff37434d),
      width: 1,
    ),
  );

  FlTitlesData titlesData = FlTitlesData(
    show: true,
    topTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
      ),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
      ),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
      ),
    ),
  );

  FlGridData gridData = FlGridData(
    show: false,
  );

  @override
  void initState() {
    super.initState();

    // Prepare initial data for graph:
    HTTPService.allData.forEach((element) => _addDataPoint(element));

    // Add listener for data, so we can update it when we receive new data
    _subscription = HTTPService.onBrouwInfoReceived.stream.listen((brouwInfo) {
      // Set state, so we can rebuild the widget
      setState(() {
        _addDataPoint(brouwInfo);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Cancel subscription to prevent memory leaks
    _subscription?.cancel();
  }

  void _addDataPoint(BrouwInfo brouwInfo) {
    wortList.add(
      FlSpot(
        wortList.length.toDouble(),
        brouwInfo.temperatures.wort,
      ),
    );
    pompList.add(
      FlSpot(
        pompList.length.toDouble(),
        brouwInfo.temperatures.pomp,
      ),
    );
    kleinList.add(
      FlSpot(
        kleinList.length.toDouble(),
        brouwInfo.digitalOutputs.klein.toDouble() + 2.0,
      ),
    );
    grootList.add(
      FlSpot(
        grootList.length.toDouble(),
        brouwInfo.digitalOutputs.groot.toDouble() - 2.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FlDotData dontShow = FlDotData(
      show: false,
    );

    LineChartBarData wortTemp = LineChartBarData(
      color: Colors.yellow,
      dotData: dontShow,
      spots: wortList,
    );

    LineChartBarData pompTemp = LineChartBarData(
      color: Colors.orange,
      dotData: dontShow,
      spots: pompList,
    );

    LineChartBarData kleinGraph = LineChartBarData(
      color: Colors.yellow,
      dotData: dontShow,
      spots: kleinList,
    );

    LineChartBarData grootGraph = LineChartBarData(
      color: Colors.orange,
      dotData: dontShow,
      spots: grootList,
    );

    return BasePaddingScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomDataRow(
              title: "Wort temperatuur",
              value:
                  "${HTTPService.getLatestData()?.temperatures.wort ?? "?"} °C",
            ),
            CustomDataRow(
              title: "Pomp temperatuur",
              value:
                  "${HTTPService.getLatestData()?.temperatures.pomp ?? "?"} °C",
            ),
            CustomDataRow(
              title: "Klein status:",
              value:
                  HTTPService.getLatestData()?.digitalOutputs.kleinState() ??
                      "?",
            ),
            CustomDataRow(
              title: "Groot status:",
              value:
                  HTTPService.getLatestData()?.digitalOutputs.grootState() ??
                      "?",
            ),
            CustomDataRow(
              title: "Plaat status:",
              value:
                  HTTPService.getLatestData()?.digitalOutputs.plaatState() ??
                      "?",
            ),
            CustomDataRow(
              title: "Pomp status:",
              value:
                  HTTPService.getLatestData()?.digitalOutputs.pompState() ??
                      "?",
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 8.0,
              ),
              child: Text(
                "Wort/Pomp temperatuur",
              ),
            ),
            SizedBox(
              height: 400,
              child: LineChart(
                key: ValueKey(HTTPService.allData),
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  gridData: gridData,
                  titlesData: titlesData,
                  borderData: borderData,
                  lineBarsData: [wortTemp, pompTemp],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 40.0,
                bottom: 8.0,
              ),
              child: Text(
                "Klein/Groot status",
              ),
            ),
            SizedBox(
              height: 400,
              child: LineChart(
                key: ValueKey(
                  HTTPService.allData,
                ),
                LineChartData(
                  minY: -3,
                  maxY: 4,
                  gridData: gridData,
                  titlesData: titlesData,
                  borderData: borderData,
                  lineBarsData: [
                    kleinGraph,
                    grootGraph,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
