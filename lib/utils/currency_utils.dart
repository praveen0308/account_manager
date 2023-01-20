
class CurrencyUtils{
  static String convert(int number) {
    final isNegativeNumber = number < 0;
    if (isNegativeNumber) {
      number = number.abs();
    }

    final words = <String>[];
    final match =
    numberWordsMapping.entries.firstWhere((entry) => number >= entry.key);
    if (number < 100) {
      words.add(match.value);
      number -= match.key;
      if (number > 0) {
        words.add(convert(number));
      }
    } else {
      final quotient = number ~/ match.key;
      final remainder = number % match.key;
      words
        ..add(convert(quotient))
        ..add(match.value);

      if (remainder > 0) {
        words.add(convert(remainder));
      }
    }

    if (isNegativeNumber) words.insert(0, 'Minus');
    return words.join(' ');
  }


  static const numberWordsMapping = {
    100000000000: 'Kharba',
    1000000000: 'Arba',
    10000000: 'Crore',
    100000: 'Lakh',
    1000: 'Thousand',
    100: 'Hundred',
    90: 'Ninety',
    80: 'Eighty',
    70: 'Seventy',
    60: 'Sixty',
    50: 'Fifty',
    40: 'Forty',
    30: 'Thirty',
    20: 'Twenty',
    19: 'Nineteen',
    18: 'Eighteen',
    17: 'Seventeen',
    16: 'Sixteen',
    15: 'Fifteen',
    14: 'Fourteen',
    13: 'Thirteen',
    12: 'Twelve',
    11: 'Eleven',
    10: 'Ten',
    9: 'Nine',
    8: 'Eight',
    7: 'Seven',
    6: 'Six',
    5: 'Five',
    4: 'Four',
    3: 'Three',
    2: 'Two',
    1: 'One',
    0: 'Zero',
  };
}
