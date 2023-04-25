import '../l_logger.dart';

abstract class LogOutput {
  late LogPrinter outputPrinter;
  late final String name;

  void handleLog(LogEvent logEvent);
}
