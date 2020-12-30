import 'dart:math' as math;

class NumberScaleFormatter {

  NumberScaleFormatter._privateConst();

  static Map<String, int> _tenthScaleMap = {
    'base' : 1,
    'kudos' : 3,
    'million' : 6,
    'billion' : 9,
    'trillion' : 13
  };

  static String _divideBy(int dividend, int divisor) => (dividend/divisor).toString();

  static int _tenthScale(int factor) => math.pow(10, factor);

  static String adjustScaling(String number) {
    if(number.length <= 3)
      return number;
    else if(number.length > 3 && number.length <= 6)
      return '${(_divideBy(int.parse(number), _tenthScale(_tenthScaleMap['kudos']))).substring(0, 3)} K';
    else if(number.length > 6 && number.length <= 9)
      return '${(_divideBy(int.parse(number), _tenthScale(_tenthScaleMap['million']))).substring(0, 4)} Million';
    else if(number.length > 9 && number.length <= 12)
      return '${(_divideBy(int.parse(number), _tenthScale(_tenthScaleMap['billion']))).substring(0, 4)} Billion';
    else
      return '${(_divideBy(int.parse(number), _tenthScale(_tenthScaleMap['trillion']))).substring(0, 4)} Trillion';
  }

}