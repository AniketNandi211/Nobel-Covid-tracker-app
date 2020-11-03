import 'dart:io';
import 'package:covid19_tracker/models/CacheFile.dart';
import 'package:covid19_tracker/utils/FileManager.dart';


    /// to identify data type
enum CacheServiceDataType {
  News,
  CovidData
}

class CacheService {

  static CacheService _instance;

      // Private constructor to prohibit making of an instance of this class
  CacheService._();

  static final Map<CacheServiceDataType, String> _cacheFileNames = {
    CacheServiceDataType.News : 'news_articles.json',
  };
  static Map<CacheServiceDataType, CacheFile> _cacheFiles = Map<CacheServiceDataType, CacheFile>();


  static Future<CacheService> get instance async {
    await _initializeCacheFileList();
    if(_instance == null){
      return CacheService._();
    } else {
      return _instance;
    }
  }

  static Future<void> _initializeCacheFileList() async {
    Directory cacheDir = await FileManager.cacheDirectory;
    _cacheFileNames.forEach( (cacheServiceDataType, _fileName) => _cacheFiles.addAll({cacheServiceDataType : CacheFile(
      fileName: _fileName,
      dir: cacheDir,
    ) }) );
  }

      /// Deletes all cached files' data
      /// i.e. it clears the App cache
  static Future<void> eraseCachedData() async =>
    _cacheFiles.forEach( (cacheServiceDataType, cacheFile) async =>
        await cacheFile.deleteFile().then( (_) => print('deleted ${cacheFile.fileName}') ));


  static get articles async {
    //dajdkajdk
  }

      ///
  static Future<Map<String, dynamic>> get testingData async => await _cacheFiles[CacheServiceDataType.News].fileContents;

}