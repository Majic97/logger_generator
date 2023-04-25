import '../l_logger.dart';

class LogEvent {
  final String level;
  final dynamic message;
  final StackTraceUnit? stackTraceData;
  final DateTime dateTime;
  final String deviceId;

  LogEvent(this.level, this.message, StackTrace? stackTrace, [this.deviceId = ''])
      : dateTime = DateTime.now(),
        stackTraceData = stackTrace != null ? StackTraceUnit.getExceptionPlace(stackTrace) : null;
}

final levelColors = {
  'info': AnsiColor.fg(12),
  'warning': AnsiColor.fg(208),
  'error': AnsiColor.fg(196),
};
