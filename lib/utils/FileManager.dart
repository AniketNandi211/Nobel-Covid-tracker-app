import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {

      // get device's document directory to store data
  static Future<Directory> get documentDirectory async => await getApplicationDocumentsDirectory();

      // get device's temporary directory to store cached data
  static Future<Directory> get cacheDirectory async => await getTemporaryDirectory();

      // create a file in the given location
  static File createFile(Directory filePath, String fileName) => new File('${filePath.path}/$fileName');

  // Helper functions for testing

      // read contents from the file
  static Future<String> readData(Directory filePath, String fileName) async =>
      await File('${filePath.path}/$fileName').readAsString();

      // write contents onto the file
  static Future<File> writeData(Directory filePath, String fileName, String data) async =>
      await File('${filePath.path}/$fileName').writeAsString('$data');

      // delete the provided file
  static Future<FileSystemEntity> deleteFile(Directory filePath, String fileName) async =>
      await File('${filePath.path}/$fileName').delete();

}