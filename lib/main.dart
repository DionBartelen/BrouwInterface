import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'HTTPService.dart';
import 'BedieningScreen.dart';
import 'ConfigScreen.dart';
import 'OverzichtScreen.dart';
import 'ProcesScreen.dart';
import 'BrouwInfo.dart';

void main() {
  runApp(BrouwInfoApp());
}

class BrouwInfoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Voorkomt draaien van de app
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Brouw info',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HttpService httpService = HttpService();
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // Start de timer bij het initialiseren van de widget
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => fetchData());
  }

  @override
  void dispose() {
    // Stop de timer bij het vernietigen van de widget
    timer.cancel();
    super.dispose();
  }

  // Methode voor het periodieke HTTP-verzoek
  void fetchData() {
    httpService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Brouw info'),
          bottom: TabBar(
            labelColor : Colors.grey.shade200,
            unselectedLabelColor: Colors.grey.shade200,
            indicatorColor: Colors.blue.shade900,
            tabs: [
              Tab(text: 'Overzicht'),
              Tab(text: 'Proces'),
              Tab(text: 'Bediening'),
              Tab(text: 'Config'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OverzichtScreen(),
            ProcesScreen(),
            BedieningScreen(),
            ConfigScreen(),
          ],
        ),
      ),
    );
  }
}
