import 'dart:convert';

import '../mlg_logger.dart';
import '../printers/log_printer.dart';
import '../assets/ansi_colors.dart';

class SimplePrinter extends LogPrinter {
  SimplePrinter(
      {Map<String, String>? prefixes,
      this.printTime = false,
      this.colors = true})
      : levelPrefixes =
            prefixes ?? {"info": '[I]', 'warning': '[W]', 'error': '[E]'};

  @override
  final Map<String, String> levelPrefixes;

  final bool printTime;
  final bool colors;

  @override
  List<String> form(LogEvent event) {
    var messageStr = _stringifyMessage(event.message);
    var timeStr = printTime ? 'TIME: ${DateTime.now().toIso8601String()}' : '';
    return ['${_labelFor(event.level)} $timeStr $messageStr'];
  }

  String _labelFor(String level) {
    var prefix = levelPrefixes[level] ?? '';
    var color = levelColors[level]!;

    return colors ? color(prefix) : prefix;
  }

  String _stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      var encoder = JsonEncoder.withIndent(null);
      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }
}
