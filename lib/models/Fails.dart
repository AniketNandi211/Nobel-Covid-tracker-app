import 'package:covid19_tracker/utils/FailsLibrary.dart';
import 'package:flutter/foundation.dart';

enum FailsType {
  NoNetwork,
  SlowNetwork,
  ServerDown,
  BadRequest,
  ServerError,
  Unknown
}

class Fails {

  final int code;
  final String codeName;
  final String info;

  Fails({
    @required this.code,
    @required this.codeName,
    @required this.info
  });

  @override
  String toString() => this.info;

  factory Fails.generateFail(FailsType enumFailType) {
    switch(enumFailType) {
      case FailsType.NoNetwork : return FailsLibrary.errors['NoNetwork'];
      case FailsType.SlowNetwork : return FailsLibrary.errors['SlowNetwork'];
      case FailsType.ServerDown : return FailsLibrary.errors['ServerDown'];
      case FailsType.BadRequest : return FailsLibrary.errors['BadRequest'];
      case FailsType.ServerError : return FailsLibrary.errors['ServerError'];
      default: return FailsLibrary.errors['Unknown'];
    }
  }
  
}
