// http_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'BrouwInfo.dart';
import 'BrouwInfoStreamBuilder.dart';

class HttpService {
  static const String baseUrl = "http://192.168.68.125:6969/api";
  static const String apiDataUrl = "$baseUrl/data";
  static const String apiSetPompModeUrl = "$baseUrl/mode/pomp/";
  static const String apiSetVerwarmModeUrl = "$baseUrl/mode/verwarm/";
  static const String apiSetTempWortModeUrl = "$baseUrl/mode/temp_wort/";
  static const String apiSetTempPompModeUrl = "$baseUrl/mode/temp_pomp/";
  static const String apiSetTempWortUrl = "$baseUrl/control/temp_wort/";
  static const String apiSetTempPompUrl = "$baseUrl/control/temp_pomp/";
  static const String apiSetBrouwModeUrl = "$baseUrl/mode/brouw/";
  static const String apiSetLoopWachtModeUrl = "$baseUrl/mode/loopWacht/";
  static const String apiSetCyclusTijdUrl = "$baseUrl/loopWacht/cyclus/";
  static const String apiSetPercentageAanUrl = "$baseUrl/loopWacht/procentAan/";
  


  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiDataUrl),);

      if (response.statusCode == 200) {
        // Parsen van JSON naar Dart-object
        Map<String, dynamic> jsonData = json.decode(response.body);
        BrouwInfo brouwInfo = BrouwInfo.fromJson(jsonData);
        BrouwInfo.allData.add(brouwInfo);
        NewDataNotifier.notify();
      } else {
        print('Fout bij het ophalen van gegevens: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Fout bij het ophalen van gegevens: $e');
    }
  }

  static void setPompMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetPompModeUrl$mode"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van pomp mode ${response.reasonPhrase}');
    }
  }

  static void setVerwarmMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetVerwarmModeUrl$mode"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van verwarm mode ${response.reasonPhrase}');
    }
  }

  static void setTempWortMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetTempWortModeUrl$mode"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van temperatuur wort mode ${response.reasonPhrase}');
    }
  }

  static void setTempPompMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetTempPompModeUrl$mode"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van temmperatuur pomp mode ${response.reasonPhrase}');
    }
  }

  static void setTempWort(double temp) async {
    final response = await http.post(Uri.parse("$apiSetTempWortUrl$temp"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van temperatuur wort mode ${response.reasonPhrase}');
    }
  }

  static void setTempPomp(double temp) async {
    final response = await http.post(Uri.parse("$apiSetTempPompUrl$temp"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van temmperatuur pomp mode ${response.reasonPhrase}');
    }
  }

  static void setBrouwMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetBrouwModeUrl$mode"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van brouw mode ${response.reasonPhrase}');
    }
  }

  static void setLoopWachtMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetLoopWachtModeUrl$mode"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van loop wacht mode ${response.reasonPhrase}');
    }
  }

  static void setCyclusTijd(double tijd) async {
    final response = await http.post(Uri.parse("$apiSetCyclusTijdUrl$tijd"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van loop wacht mode ${response.reasonPhrase}');
    }
  }

  static void setPercentageAan(double percentage) async {
    final response = await http.post(Uri.parse("$apiSetPercentageAanUrl$percentage"));
    if(response.statusCode != 200) {
      print('Fout bij schrijven van loop wacht mode ${response.reasonPhrase}');
    }
  }


  
}