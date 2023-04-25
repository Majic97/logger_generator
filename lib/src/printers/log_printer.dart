import '../mlg_logger.dart';
import '../assets/resource.dart';

abstract class LogPrinter {
  late final Map<String, String> levelPrefixes;

  List<String> form(LogEvent event);

  void fun() {}
}
