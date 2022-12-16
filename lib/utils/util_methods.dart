import 'package:account_manager/utils/extension_methods.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

class UtilMethods{
  static String convertIntoWords(num number){
    String inWords = NumberToWordsEnglish.convert(number.toInt());
    inWords = inWords.replaceAll("-", " ");
    inWords = inWords.capitalize();

    return inWords;
  }
}