import 'dart:convert';
import 'dart:io';
import 'package:covid19_tracker/utils/FileManager.dart';
import 'package:flutter/foundation.dart';

class CacheFile {

  File file;
  Duration validity;

  CacheFile({
    @required this.file,
    this.validity = const Duration(days: 1),
  }) : assert(file != null);

  Future<Map<String, dynamic>> get fileContents async {
   String _contents =  await FileManager.readFileData(file);
   return json.decode(_contents);
  }

}