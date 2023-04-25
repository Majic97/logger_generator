import 'package:flutter/material.dart';
import '../mlg_logger.dart';

class ConsoleLogOutput implements LogOutput {
  ConsoleLogOutput(this.name, {LogPrinter? printer})
      : outputPrinter = printer ?? SimplePrinter();

  @override
  LogPrinter outputPrinter;

  @override
  String name;

  @override
  void handleLog(LogEvent logEvent) {
    for (var e in outputPrinter.form(logEvent)) {
      debugPrint(e);
    }
  }
}
