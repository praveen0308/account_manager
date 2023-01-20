
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage{

  static const _gstExpression = "gstExpression";
  static const _gstAnswer = "gstAnswer";

  static Future<void> setGstExpression(String txt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_gstExpression,txt);
  }
  static Future<String?> getGstExpression() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_gstExpression);
  }


  static Future<void> setGstAnswer(String txt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_gstAnswer,txt);
  }
  static Future<String?> getGstAnswer() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_gstAnswer);
  }

}