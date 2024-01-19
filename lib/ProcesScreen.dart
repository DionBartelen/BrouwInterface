// proces_screen.dart
import 'package:flutter/material.dart';
import 'BrouwInfo.dart';
import 'HTTPService.dart';

const List<String> listBrouwModes = <String>['Uit', 'Loop wacht', 'Auto'];
const List<String> listLoopWachtModes = <String>['Alles', 'Klein en groot', 'Klein en plaat', 'Groot en plaat', 'Klein', 'Groot', 'Plaat', 'Uit'];

class ProcesScreen extends StatefulWidget {
    @override
    _ProcesScreenState createState() => _ProcesScreenState();
}

class  _ProcesScreenState extends State<ProcesScreen> {
  static String brouwDropdownValue = listBrouwModes[BrouwInfo.allData.lastOrNull?.brouw.brouwMode??0];
  static String loopWachtDropdownValue = listLoopWachtModes[BrouwInfo.allData.lastOrNull?.brouw.loopWachtMode??0];
  static String cyclusTijd = BrouwInfo.allData.lastOrNull?.brouw.cyclusTijd.toString() ?? "0";
  static String percentageAan= BrouwInfo.allData.lastOrNull?.brouw.percentageAan.toString() ?? "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView( child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [Expanded(flex: 6, child:Text("Brouw mode:")), buildDropDownBrouw()],),
        Row(children: [Expanded(flex: 6, child:Text("Loop-Wacht mode:")), buildDropDownLoopWacht()],),
         Row(children: [Expanded(flex: 6, child: Text("Temperatuur wort:")), Expanded(flex: 4, child: TextFormField(initialValue: cyclusTijd, decoration: InputDecoration(labelText: ""),keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true), textInputAction: TextInputAction.go, onFieldSubmitted: (value) => HttpService.setCyclusTijd(double.parse(value)),),)],),
        Row(children: [Expanded(flex: 6, child: Text("Temperatuur pomp:")), Expanded(flex: 4, child: TextFormField(initialValue: percentageAan, decoration: InputDecoration(labelText: ""),keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true), textInputAction: TextInputAction.go, onFieldSubmitted: (value) => HttpService.setPercentageAan(double.parse(value)),),)],),
        ],)
      )
    );
  }

  Widget buildDropDownBrouw() {
    //brouwDropdownValue = listBrouwModes[BrouwInfo.allData.lastOrNull?.brouw.brouwMode??0];
    return DropdownButton<String>(
      value: brouwDropdownValue,
      icon: const Icon(Icons.arrow_drop_down_sharp),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        if(value != null) {
          String val = value;
          HttpService.setBrouwMode(listBrouwModes.indexOf(val));
        }

        setState(() {
          brouwDropdownValue = value!;
        });
        
      },
      items: listBrouwModes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildDropDownLoopWacht() {
    //loopWachtDropdownValue = listLoopWachtModes[BrouwInfo.allData.lastOrNull?.brouw.loopWachtMode??0];
    return DropdownButton<String>(
      value: loopWachtDropdownValue,
      icon: const Icon(Icons.arrow_drop_down_sharp),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        if(value != null) {
          String val = value;
          HttpService.setLoopWachtMode(listLoopWachtModes.indexOf(val));
        }

        setState(() {
          loopWachtDropdownValue = value!;
        });
        
      },
      items: listLoopWachtModes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}