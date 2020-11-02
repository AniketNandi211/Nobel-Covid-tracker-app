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
  static List<CacheFile> _cacheFiles = <CacheFile>[];
  //static Map<CacheServiceDataType, String> _cacheFiles2 = Map<CacheServiceDataType, String>();


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
    _cacheFiles.add(
      CacheFile(
          fileName: _cacheFileNames[CacheServiceDataType.News],
          dir: cacheDir)
    );
    print('cacheFileList length : ${_cacheFileNames.length}');
    //_cacheFiles[0].fileContents.then((value) => print(value['hey']));
    //print(_cacheFiles[0].fileContents);
  }

      /// Deletes all cached files and data
      /// i.e. it clears the App cache
  static Future<void> eraseCachedData() async =>
    _cacheFiles.forEach( (CacheFile file) async =>
        await file.deleteFile().then( (value) => print('deleted ${file.fileName}') ));


  static get articles async {
    //dajdkajdk
  }

  static Future<Map<String, dynamic>> get testingData async => await _cacheFiles[0].fileContents;

}