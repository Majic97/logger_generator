import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

import '../l_logger.dart';
import 'dart:io';

class FileLogOutput implements LogOutput {
  FileLogOutput(this.name, {LogPrinter? printer, String? filePrefix})
      : outputPrinter = printer ?? SimplePrinter(),
        prefix = filePrefix != null ? '$filePrefix-' : '';

  @override
  LogPrinter outputPrinter;

  @override
  String name;

  String prefix;
  File? _file;

  void init() async {
    String directory = (await getApplicationSupportDirectory()).path;
    if (directory.isNotEmpty) {
      String date = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      String path = "$directory/${prefix}loggs-$date.csv";
      _file = File(path);
    }
  }

  @override
  void handleLog(LogEvent logEvent) {
    if (_file == null) init();

    List<List<String>> data = [
      [
        logEvent.level,
        logEvent.message != null ? 'Message: ${logEvent.message}' : '',
        '${logEvent.dateTime.toString()} ',
        logEvent.stackTraceData != null ? logEvent.stackTraceData.toString() : ''
      ],
      [] // необходимо для правильного добавления новой строки в файл
    ];
    writeToFile(data);
  }

  void writeToFile(List<List<String>> data) async {
    var csvData = const ListToCsvConverter().convert(data);
    await _file?.writeAsString(csvData, mode: FileMode.append);
  }
}
