import 'dart:math' as math;
import 'package:flutter/foundation.dart';

class NumberScaleFormatter {

  NumberScaleFormatter._privateConst();

  static Map<int, String> _numberIdentityMap = {
    1 : '',
    4 : 'K',
    7 : ' Million',
    10 : ' Billion'
  };

  static double _toScaledDouble(String number, {@required int factor}) => int.parse(number)/math.pow(10, factor);

  /// this function omits the decimal point in the last position
  /// of the string if present. e.g. 1234. => 1234
  static String _decimalRemover(String number) =>
      number.endsWith('.') ? number.substring(0, number.length - 1) : number;

  static String _formatNumber(String number, {int scaleIdentityFactor = 1}) => // default  scaleIdentityFactor = 1
     '${_decimalRemover(_toScaledDouble(number, factor: scaleIdentityFactor - 1).toString().substring(0, 4))}${_numberIdentityMap[scaleIdentityFactor]}';

  static String adjustScaling(String number) {
    switch(number.length) {
      case 1 :
      case 2 :
      case 3 : return number;
      case 4 : return _formatNumber(number, scaleIdentityFactor: 4);
      case 5 : return _formatNumber(number, scaleIdentityFactor: 4);
      case 6 : return _formatNumber(number, scaleIdentityFactor: 4);
      case 7 : return _formatNumber(number, scaleIdentityFactor: 7);
      case 8 : return _formatNumber(number, scaleIdentityFactor: 7);
      case 9 : return _formatNumber(number, scaleIdentityFactor: 7);
      case 10 : return _formatNumber(number, scaleIdentityFactor: 10);
      default : return number;
    }
  }

}