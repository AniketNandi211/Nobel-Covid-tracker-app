import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// FileManager manages all file related stuff
/// including deleting, writing, reading
class FileManager {

      // can't be instantiated from anywhere but this class
  FileManager._cantMakeObj();

      /// get device's document directory to store data
  static Future<Directory> get documentDirectory async => await getApplicationDocumentsDirectory();

      /// get device's temporary directory to store cached data
  static Future<Directory> get cacheDirectory async => await getTemporaryDirectory();

      /// create a file in the given location
  static File createFile({Directory filePath, String fileName}) => new File('${filePath.path}/$fileName');

      /// read contents from the file (with given directory and filename)
  static Future<String> readData({Directory filePath, String fileName}) async =>
      await File('${filePath.path}/$fileName').readAsString();

      /// read contents from the file (with given file)
  static Future<String> readFileData(File file) async =>
      await file.readAsString();

      /// write contents onto the file (with given directory, filename and data : String )
  static Future<File> writeData({
    Directory filePath, String fileName, String data}) async =>
      await File('${filePath.path}/$fileName').writeAsString('$data');

      /// write contents onto the file (with given file and data : String )
  static Future<File> writeFileData({File file, String data}) async =>
      await file.writeAsString('$data');

      /// delete the file (with given directory and filename)
  static Future<FileSystemEntity> delete({
    Directory filePath, String fileName}) async =>
      await File('${filePath.path}/$fileName').delete();

      /// delete the file (with given file)
  static Future<FileSystemEntity> deleteFile(File file) async =>
      await file.delete();

      /// return whether the given file exists or not
  static Future<bool> doesFileExist(File file) async => await file.exists();

      /// return whether the file (with given directory and filename) exists or not
  static Future<bool> doesExist({Directory filePath, String fileName}) async =>
      await File('${filePath.path}/$fileName').exists();

}