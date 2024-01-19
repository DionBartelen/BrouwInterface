// http_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:brouw/models/brouw_info.dart';
import 'package:http/http.dart' as http;

class HTTPService {

  static const int maxDataPoints = 300;

  static List<BrouwInfo> allData = List.empty(growable: true);

  final String testUrl = "http://172.16.4.2:3000";

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

  // Callback for BrouwInfo
  static StreamController<BrouwInfo> onBrouwInfoReceived =
      StreamController<BrouwInfo>.broadcast();

  Future<bool> fetchData() async {
    try {
      // Attempt to parse URL
      final response = await http.get(
        Uri.parse(baseUrl),
      );

      // If the status is not OK, return code.
      if (response.statusCode != 200) {
        print('Fout bij het ophalen van gegevens: ${response.reasonPhrase}');
        return false; // Data fetching failed, returning false
      }

      // Parsen van JSON naar Dart-object
      Map<String, dynamic> jsonData = json.decode(response.body);
      final BrouwInfo brouwInfo = BrouwInfo.fromJson(jsonData);
      onBrouwInfoReceived.add(brouwInfo);
      allData.add(brouwInfo);

      // Remove old data, which should be at the start of the list
      if(allData.length > maxDataPoints) {
        allData.removeRange(0, allData.length - maxDataPoints);
      }

      return true; // Data fetching succeeded, returning true
    } catch (e) {
      print('Fout bij het ophalen van gegevens: $e');
      return false; // Data fetching failed, returning false
    }
  }

  static BrouwInfo? getLatestData() {
    if(allData.isEmpty) return null;
    return allData.last;
  }

  static Future<void> setPompMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetPompModeUrl$mode"));
    _printError(response);
  }

  static Future<void> setVerwarmMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetVerwarmModeUrl$mode"));
    _printError(response);
  }

  static Future<void> setTempWortMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetTempWortModeUrl$mode"));
    _printError(response);
  }

  static Future<void> setTempPompMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetTempPompModeUrl$mode"));
    _printError(response);
  }

  static Future<void> setTempWort(double temp) async {
    final response = await http.post(Uri.parse("$apiSetTempWortUrl$temp"));
    _printError(response);
  }

  static Future<void> setTempPomp(double temp) async {
    final response = await http.post(Uri.parse("$apiSetTempPompUrl$temp"));
    _printError(response);
  }

  static Future<void> setBrouwMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetBrouwModeUrl$mode"));
    _printError(response);
  }

  static Future<void> setLoopWachtMode(int mode) async {
    final response = await http.post(Uri.parse("$apiSetLoopWachtModeUrl$mode"));
    _printError(response);
  }

  static Future<void> setCyclusTijd(double tijd) async {
    final response = await http.post(Uri.parse("$apiSetCyclusTijdUrl$tijd"));
    _printError(response);
  }

  static Future<void> setPercentageAan(double percentage) async {
    final response =
        await http.post(Uri.parse("$apiSetPercentageAanUrl$percentage"));
    _printError(response);
  }

  static void _printError(http.Response response) {
    if (response.statusCode == 200) return;
    print('Fout bij schrijven van gegevens: ${response.reasonPhrase}');
  }
}
