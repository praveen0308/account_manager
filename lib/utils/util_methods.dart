import 'dart:math';

import 'package:account_manager/utils/extension_methods.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

class UtilMethods{
  static String convertIntoWords(num number){
    String inWords = NumberToWordsEnglish.convert(number.toInt());
    inWords = inWords.replaceAll("-", " ");
    inWords = inWords.capitalize();

    return inWords;
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
}