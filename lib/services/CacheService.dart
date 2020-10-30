import 'dart:io';

import 'package:covid19_tracker/utils/FileManager.dart';
import 'package:flutter/foundation.dart';


    // to identify data type
enum CacheServiceDataType {
  News,
  CovidData
}

class CacheService {

  File _cacheFile;
  Directory _filePath;

  static Map<CacheServiceDataType, String> _cacheFileNames = {
    CacheServiceDataType.News : 'news_articles.json',
  };

  Duration cacheTimeOut;

      // by default cached data will expire within 24 hours
  CacheService({
    this.cacheTimeOut = const Duration(days: 1),
  });

  set filePath(Directory path) { _filePath = path; }

  Future<bool> _doesFileExist() async => await File(_filePath.path).exists();

    // * optional
  Future<DateTime> _fileLastModified() async => await File(_filePath.path).lastModified();

  /*
  Future<bool> hasExpired(File _file) async => {

  };
   */

  /*
   //singleton if needed
    // private constructor
  static CacheService _instance;
  CacheService._();

  static CacheService get instance {
    if(_instance == null){
      return CacheService._();
    } else {
      return _instance;
    }
  }
   */

}