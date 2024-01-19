// overzicht_screen.dart

import 'BrouwInfoStreamBuilder.dart';
import 'package:brouw/BrouwInfo.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OverzichtScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<FlSpot> wort_list = List.empty(growable: true);
    List<FlSpot> pomp_list = List.empty(growable: true);
    List<FlSpot> klein_list = List.empty(growable: true);
    List<FlSpot> groot_list = List.empty(growable: true);

    int dataPoints = 300;
    if(BrouwInfo.allData.length < 300) {
      dataPoints = BrouwInfo.allData.length;
    }

    for(int i = BrouwInfo.allData.length - dataPoints; i < dataPoints; i++) {
      wort_list.add(FlSpot(i.toDouble(), BrouwInfo.allData[i].temperatures.wort));
      pomp_list.add(FlSpot(i.toDouble(), BrouwInfo.allData[i].temperatures.pomp));
      klein_list.add(FlSpot(i.toDouble(), BrouwInfo.allData[i].digitalOutputs.klein.toDouble() + 2.0));
      groot_list.add(FlSpot(i.toDouble(), BrouwInfo.allData[i].digitalOutputs.groot.toDouble() - 2.0));
    }

    LineChartBarData wort_temp = LineChartBarData( color: Colors.yellow, dotData: FlDotData(show: false), spots: wort_list);
    LineChartBarData pomp_temp = LineChartBarData(color: Colors.orange, dotData: FlDotData(show: false), spots: pomp_list);

    LineChartBarData klein_graph = LineChartBarData( color: Colors.yellow, dotData: FlDotData(show: false), spots: klein_list);
    LineChartBarData groot_graph = LineChartBarData(color: Colors.orange, dotData: FlDotData(show: false), spots: groot_list);

    return Scaffold(

        body: 
       SingleChildScrollView( child:  Padding(
          padding: const EdgeInsets.all(32.0),
          child:
          Column(children: [
            Row(children: [const Expanded(flex: 6, child:Text("Wort temperatuur:")), Container(child: StreamBuilder<bool>(stream: NewDataNotifier.dataStream,builder: (context, snapshot) {return Text('${BrouwInfo.allData.lastOrNull?.temperatures.wort} °C');},),),]),
            Row(children: [const Expanded(flex: 6, child:Text("Pomp temperatuur:")), Container(child: StreamBuilder<bool>(stream: NewDataNotifier.dataStream,builder: (context, snapshot) {return Text('${BrouwInfo.allData.lastOrNull?.temperatures.pomp} °C');},),),]),
            Row(children: [const Expanded(flex: 6, child:Text("Klein status:")), Container(child: StreamBuilder<bool>(stream: NewDataNotifier.dataStream,builder: (context, snapshot) {var status = BrouwInfo.allData.lastOrNull?.digitalOutputs.klein; if(status!= null && status == 1){return Text("aan");} return Text("uit");},),),]),
            Row(children: [const Expanded(flex: 6, child:Text("Groot satus:")), Container(child: StreamBuilder<bool>(stream: NewDataNotifier.dataStream,builder: (context, snapshot) {var status = BrouwInfo.allData.lastOrNull?.digitalOutputs.groot; if(status!= null && status == 1){return Text("aan");} return Text("uit");},),),]),
            Row(children: [const Expanded(flex: 6, child:Text("Plaat status:")), Container(child: StreamBuilder<bool>(stream: NewDataNotifier.dataStream,builder: (context, snapshot) {var status = BrouwInfo.allData.lastOrNull?.digitalOutputs.plaat; if(status!= null && status == 1){return Text("aan");} return Text("uit");},),),]),
            Row(children: [const Expanded(flex: 6, child:Text("Pomp status:")), Container(child: StreamBuilder<bool>(stream: NewDataNotifier.dataStream,builder: (context, snapshot) {var status = BrouwInfo.allData.lastOrNull?.digitalOutputs.pomp; if(status!= null && status == 1){return Text("aan");} return Text("uit");},),),]),
            Container(
          height: 400,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                key: ValueKey(BrouwInfo.allData),
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  gridData: FlGridData(show: false,),
                  titlesData: FlTitlesData( show: true,
                     topTitles: AxisTitles(
                       sideTitles: SideTitles(showTitles: false),
                     ),
                     rightTitles: AxisTitles(
                       sideTitles: SideTitles(showTitles: false),
                     ),
                     bottomTitles: AxisTitles(
                       sideTitles: SideTitles(showTitles: false),
                       ),
                      
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                lineBarsData: [ wort_temp, pomp_temp ],
            ),
          ),
        ),
      ),

      Container(
          height: 400,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                key: ValueKey(BrouwInfo.allData),
                LineChartData(
                  minY: -3,
                  maxY: 4,
                  gridData: FlGridData(show: false,),
                  titlesData: FlTitlesData( show: true,
                     topTitles: AxisTitles(
                       sideTitles: SideTitles(showTitles: false),
                     ),
                     rightTitles: AxisTitles(
                       sideTitles: SideTitles(showTitles: false),
                     ),
                     bottomTitles: AxisTitles(
                       sideTitles: SideTitles(showTitles: false),
                       ),
                      
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                lineBarsData: [ klein_graph, groot_graph ],
            ),
          ),
        ),
      ),
          ],)
        ))
    );
  }
}
