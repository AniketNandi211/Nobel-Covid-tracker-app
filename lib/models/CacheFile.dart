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



      /// This function : fuck this function
  /// I'm having a headache
  /// have to refactor this cuz am also gonna fetch the covid details
  Future<List<dynamic>> get fileContents async {
    try{
      if (await FileManager.doesFileExist(_file)) {
        String _data;
        print('Loading from cache');
        _data = await FileManager.readFileData(_file).then(
                (String _fileContents) => json.decode(_fileContents) );
        return json.decode(_data);
      } else {
        print('Loading from Internet');
        dynamic jsonData = await NewsApiService.loadArticles(); // API request
        print(jsonData);
        if (jsonData != null) await FileManager.writeFileData(file: _file, data: json.encode(jsonData));

      }

    } on Fails catch(fail) {
      print('from CacheFile class(Fails) : ${fail.toString()}');
    } catch (error) {
      print('from CacheFile class : ${error.toString()}');
    }
    /** in case of _data is null , returns empty json object {}
     *  otherwise Runtime Error : getter was called on null occurs
     *  while parsing the json object ,
     *  which suppresses any error message thrown by API service
     *  that should render on screen to tell the user what went wrong
     */
  }

      /// Deletes the current file
  Future<void> deleteFile() async {
    await FileManager.deleteFile(_file);
  }

}
