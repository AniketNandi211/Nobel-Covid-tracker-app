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

        /**
         * Getting the data as String from file then converting it into
         * Map<String, dynamic>
         */

        return _cacheFiles[CacheServiceDataType.News].contents.then((data) => json.decode(data));
      } else {
        List<dynamic> jsonData = await NewsApiService.loadArticles(); // API request
        print('Loaded from internet');

        /** json.encode converts the Map<String, dynamic> to String data
         * So converting decoded data to write into file in order to access it
         * later as Cache storage
         */

        if (jsonData != null) _cacheFiles[CacheServiceDataType.News].writeContents(json.encode(jsonData));
        // simply return the already decoded data -> Map<String, dynamic>
        return jsonData;
      }
    } on Fails catch(fail) {
      print('from CacheFile service(Fails) : ${fail.toString()}');
    } catch (error) {
      print('from CacheFile service : ${error.toString()}');
    }
  }

}