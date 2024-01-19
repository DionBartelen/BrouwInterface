// handbediening_screen.dart
import 'package:flutter/material.dart';
import 'BrouwInfo.dart';
import 'HTTPService.dart';

const List<String> listPompModes = <String>['Auto', 'Hand aan', 'Hand uit'];
const List<String> listVerwarmModes = <String>['Auto', 'Alles', 'Klein en groot', 'Klein en plaat', 'Groot en plaat', 'Klein', 'Groot', 'Plaat', 'Uit'];
const List<String> listTempModes = <String>['Auto', 'Hand'];

class BedieningScreen extends StatefulWidget {
    @override
    _BedieningScreenState createState() => _BedieningScreenState();
}

class  _BedieningScreenState extends State<BedieningScreen> {
  static bool temp_wort_man = BrouwInfo.allData.lastOrNull?.modes.tempWort == 1;
  static bool temp_pomp_man = BrouwInfo.allData.lastOrNull?.modes.tempPomp == 1;
  static String temp_wort = BrouwInfo.allData.lastOrNull?.temperatures.wort.toString() ?? "0";
  static String temp_pomp = BrouwInfo.allData.lastOrNull?.temperatures.pomp.toString() ?? "0";
  static String pompDropdownValue = listPompModes[BrouwInfo.allData.lastOrNull?.modes.pomp??0];
  static String verwarmDropdownValue = listVerwarmModes[BrouwInfo.allData.lastOrNull?.modes.verwarm??0];
  static String tempWortDropdownValue = listTempModes[BrouwInfo.allData.lastOrNull?.modes.tempWort??0];
  static String tempPompDropdownValue = listTempModes[BrouwInfo.allData.lastOrNull?.modes.tempPomp??0];

  @override
  Widget build(BuildContext context) {
    temp_wort_man = BrouwInfo.allData.lastOrNull?.modes.tempWort == 1;
    temp_pomp_man = BrouwInfo.allData.lastOrNull?.modes.tempPomp == 1;
    temp_wort = BrouwInfo.allData.lastOrNull?.temperatures.wort.toString() ?? "0";
    temp_pomp = BrouwInfo.allData.lastOrNull?.temperatures.pomp.toString() ?? "0";

    print(BrouwInfo.allData.lastOrNull?.modes.verwarm);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView( child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [Expanded(flex: 6, child:Text("Pomp mode:")), buildDropDownPomp()],),
        Row(children: [Expanded(flex: 6, child:Text("Verwarm mode:")), buildDropDownVerwarm()],),
        Row(children: [Expanded(flex: 6, child:Text("Temperatuur wort mode:")), buildDropDownTempWort()],),
        Row(children: [Expanded(flex: 6, child:Text("Temperatuur pomp mode:")), buildDropDownTempPomp()],),
        Row(children: [Expanded(flex: 6, child: Text("Temperatuur wort:")), Expanded(flex: 4, child: TextFormField(enabled: temp_wort_man, initialValue: temp_wort, decoration: InputDecoration(labelText: ""),keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true), textInputAction: TextInputAction.go, onFieldSubmitted: (value) => HttpService.setTempWort(double.parse(value)),),)],),
        Row(children: [Expanded(flex: 6, child: Text("Temperatuur pomp:")), Expanded(flex: 4, child: TextFormField(enabled: temp_pomp_man, initialValue: temp_pomp, decoration: InputDecoration(labelText: ""),keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true), textInputAction: TextInputAction.go, onFieldSubmitted: (value) => HttpService.setTempPomp(double.parse(value)),),)],),
      ],)
      )
      );
  }

  Widget buildDropDownPomp() {
    //pompDropdownValue = listPompModes[BrouwInfo.allData.lastOrNull?.modes.pomp??0];
    return DropdownButton<String>(
      value: pompDropdownValue,
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
          HttpService.setPompMode(listPompModes.indexOf(val));
        }

        setState(() {
          pompDropdownValue = value!;
        });
        
      },
      items: listPompModes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildDropDownVerwarm() {
    //verwarmDropdownValue = listVerwarmModes[BrouwInfo.allData.lastOrNull?.modes.verwarm??0];
    return DropdownButton<String>(
      value: verwarmDropdownValue,
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
          HttpService.setVerwarmMode(listVerwarmModes.indexOf(val));
        }

        setState(() {
          verwarmDropdownValue = value!;
        });

      },
      items: listVerwarmModes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildDropDownTempWort() {
     //tempWortDropdownValue = listTempModes[BrouwInfo.allData.lastOrNull?.modes.tempWort??0];
    return DropdownButton<String>(
      value: tempWortDropdownValue,
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
          HttpService.setTempWortMode(listTempModes.indexOf(val));
        }

        setState(() {
          tempWortDropdownValue = value!;
        });

        Future.delayed(Duration(milliseconds: 1500), () => {
        setState(() {
          tempWortDropdownValue = value!;
        })
        });

      },
      items: listTempModes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget buildDropDownTempPomp() {
    //tempPompDropdownValue = listTempModes[BrouwInfo.allData.lastOrNull?.modes.tempPomp??0];
    return DropdownButton<String>(
      value: tempPompDropdownValue,
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
          HttpService.setTempPompMode(listTempModes.indexOf(val));
        }

        setState(() {
          tempPompDropdownValue = value!;
        });

        Future.delayed(Duration(milliseconds: 1500), () => {
          setState(() {
            tempPompDropdownValue = value!;
          })
        });

      },
      items: listTempModes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


