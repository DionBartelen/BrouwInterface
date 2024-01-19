import 'package:brouw/screens/bedienings_screen.dart';
import 'package:brouw/screens/config_screen.dart';
import 'package:brouw/services/http_service.dart';
import 'package:brouw/screens/overzicht_scherm.dart';
import 'package:brouw/screens/process_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(const BrouwInfoApp());
}

class BrouwInfoApp extends StatelessWidget {
  const BrouwInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Voorkomt draaien van de app
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      theme: ThemeData.dark()
      .copyWith(dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HTTPService httpService = HTTPService();
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // Start de timer bij het initialiseren van de widget
    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (_) => httpService.fetchData(),
    );
  }

  @override
  void dispose() {
    // Stop de timer bij het vernietigen van de widget
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(
                MdiIcons.beer,
              ),
              const SizedBox(
                width: 8.0,
              ),
              const Text(
                'Brouw info',
              ),
            ],
          ),
          bottom: TabBar(
            labelColor: Colors.grey.shade200,
            unselectedLabelColor: Colors.grey.shade200,
            indicatorColor: Colors.blue.shade900,
            tabs: const [
              Tab(
                text: 'Overzicht',
              ),
              Tab(
                text: 'Proces',
              ),
              Tab(
                text: 'Bediening',
              ),
              Tab(
                text: 'Config',
              ),
            ],
          ),
        ),
        body: const TabBarView(
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
