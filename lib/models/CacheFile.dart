import 'dart:convert';
import 'dart:io';
import 'package:covid19_tracker/services/NewsApiService.dart';
import 'package:covid19_tracker/utils/FileManager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Fails.dart';

class CacheFile {

  File _file;

  Duration validity;
  Directory dir;
  String fileName;

      /// by default cached data will expire within 24 hours
  CacheFile({
    @required this.fileName,
    @required this.dir,
    this.validity = const Duration(days: 1),
  }){
    _file = File('${dir.path}/$fileName');
  }

  /// this function writes into cache file
  Future<void> writeContents(String _data) async =>
    await FileManager.writeFileData(file: _file, data: _data);

  /// this function reads data from cache file and returns it
  Future<dynamic> get contents async => await FileManager.readFileData(_file);

      /// Deletes the current file
  Future<void> deleteFile() async {
    await FileManager.deleteFile(_file);
  }

}
