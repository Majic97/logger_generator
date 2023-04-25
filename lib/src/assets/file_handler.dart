import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

abstract class FileHandler {
  static Future<List<String>> getScvFilesPath() async {
    String directory = (await getApplicationSupportDirectory()).path;

    return (await Directory(directory).list().toList())
        .map((el) => el.path)
        .toList()
      ..removeWhere((el) => !el.contains('.csv'));
  }

  static Future<List<List>?> getCsvDataFromFile(String path) async {
    try {
      var csvFile = File(path).openRead();

      var data = await csvFile
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();

      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<void> deleteScvFile(String path) async {
    if (path.contains('.csv') == false) return;

    File(path).delete();
  }
}
