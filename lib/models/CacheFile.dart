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


      /// Reads the file and returns data as Map<String, dynamic> if file exists
  Future<Map<String, dynamic>> get fileContents async {
    String _data;
    try{
      if (await FileManager.doesFileExist(_file)) {
        _data = await FileManager.readFileData(_file);
        print('Loaded from cache');
        print(_data);
      } else {
        _data = await NewsApiService.loadArticles(); // API request
        print('loaded from Internet');
        await FileManager.writeFileData(file: _file, data: _data);
        print(_data);
      }

    } on Fails catch(fail) {
      print('from CacheFile class(Fails) : ${fail.toString()}');
    } catch (error) {
      print('from CacheFile class : ${error.toString()}');
    }
    return json.decode(_data);
  }

      /// Deletes the current file
  Future<void> deleteFile() async {
    await FileManager.deleteFile(_file);
  }

  File _createCacheFile(Directory dir, String fileName) =>
       FileManager.createFile(filePath: dir, fileName: fileName);

}