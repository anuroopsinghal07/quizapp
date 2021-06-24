import 'package:flutter/services.dart' show rootBundle;
import 'package:quizapp/Model/settings.dart';
import 'dart:convert';

class SettingsDataProvider {
  Future<Settings> fetchSettings() async {
    var jsonText = await rootBundle.loadString('assets/settings.json');

    return _parseJsonText(jsonText);
  }

  Settings _parseJsonText(String jsonText) {
    try {
      Map<String, dynamic> map = json.decode(jsonText);

      return Settings.fromJson(map);
    } catch (_) {
      throw Exception('failed to load settings');
    }
  }
}
