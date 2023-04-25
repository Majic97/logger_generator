import '../mlg_logger.dart';

class ListLogOutput implements LogOutput {
  // в аргумент list можно вставлять ТОЛЬКО ССЫЛКУ НА УЖЕ СУЩЕСТВУЮЩИЕ ОБЪЕКТЫ
  ListLogOutput(this.name, this.logsListContainer, {LogPrinter? printer})
      : outputPrinter = printer ?? SimplePrinter();

  @override
  LogPrinter outputPrinter;

  @override
  String name;

  // List это контейнер хранения логов. Здесь list является ссылкой.
  List<String> logsListContainer;

  @override
  void handleLog(LogEvent logEvent) {
    logsListContainer.add('${logEvent.level} '
        'Message:${logEvent.message ?? ''}'
        '${logEvent.dateTime.toString()}'
        '${logEvent.stackTraceData?.toString()}');
  }
}
