import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';
import 'visitor.dart';

class LoggerGenerator extends GeneratorForAnnotation<LoggerMark> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = Visitor();
    element.visitChildren(visitor);

    var classBuffer = StringBuffer();

    classBuffer.writeln("extension \$${visitor.className} on ${visitor.className}{");

    for (var el in visitor.settings.keys) {
      classBuffer.writeln(createMethod(el, visitor.settings[el]!));
    }

    classBuffer.writeln('}');

    return classBuffer.toString();
  }

  String createMethod(String type, List<String> outputs) {
    var methodBuffer = StringBuffer();

    methodBuffer.writeln("void $type(dynamic message){");
    methodBuffer.writeln("String level = \"$type\";");
    methodBuffer.writeln("var logEvent = LogEvent(level, message, StackTrace.current);\n");
    for (var el in outputs) {
      methodBuffer.writeln("$el.handleLog(logEvent); ");
    }
    methodBuffer.writeln("}");

    return methodBuffer.toString();
  }
}
