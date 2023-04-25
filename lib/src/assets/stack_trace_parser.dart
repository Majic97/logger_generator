import 'package:flutter/foundation.dart';

class StackTraceUnit {
  StackTraceUnit(this.method, this.path, this.line);

  final String path;
  final String method;
  final int line;

  //возращает trace участка в котором была вызвана ошибка
  static StackTraceUnit? getExceptionPlace(StackTrace trace) {
    for (var frame in StackFrame.fromStackTrace(trace)) {
      // обработчих необходим для отсеивания exception в библиотеках
      if (frame.package != '<unknown>') {
        return StackTraceUnit(frame.method, frame.packagePath, frame.line);
      }
    }
    return null;
  }

  @override
  String toString() {
    return 'Method: $method Path: $path line:$line';
  }
}
