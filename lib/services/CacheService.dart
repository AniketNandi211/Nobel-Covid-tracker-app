import 'dart:convert';
import 'dart:io';
import 'package:covid19_tracker/models/CacheFile.dart';
import 'package:covid19_tracker/models/Fails.dart';
import 'package:covid19_tracker/utils/FileManager.dart';
import 'package:covid19_tracker/services/NewsApiService.dart';


    /// Identifies the data type
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
    File _articleFile =
        File('${_cacheFiles[CacheServiceDataType.News].dir.path}/${_cacheFiles[CacheServiceDataType.News].fileName}');
    try {
      if (await FileManager.doesFileExist(_articleFile)) {
        print('Loaded from cache ');
        /** decoding the cached data two times
         *  first time : To convert from String file content to
         *  List of String key : String value pair
         *  second time : to convert from List object to Dart Map<String, dynamic>
         */
        return _cacheFiles[CacheServiceDataType.News].contents.then((data) => json.decode(json.decode(data)));
      } else {
        dynamic jsonData = await NewsApiService.loadArticles(); // API request
        print('Loaded from internet - $jsonData');
          // json.encode converts the Map<String, dynamic> to String data
        if (jsonData != null) _cacheFiles[CacheServiceDataType.News].writeContents(json.encode(jsonData));
        return json.decode(jsonData);
      }
    } on Fails catch(fail) {
      print('from CacheFile service(Fails) : ${fail.toString()}');
    } catch (error) {
      print('from CacheFile service : ${error.toString()}');
    }
  }

  
  static Future<List<dynamic>> get testingData async {
  try {
    return await _cacheFiles[CacheServiceDataType.News].fileContents;
  } catch (error) {
    //throw Fails.generateFail(FailsType.Unknown).info = error.toString();
    print('error from CS : ${error.toString()}');
    }
  }

}