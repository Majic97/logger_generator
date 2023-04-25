import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

class Visitor extends SimpleElementVisitor<void> {
  //ключ - тип ошибки, знчение - список инстансов относящихся к ней
  Map<String, List<String>> settings = {};
  String className = '';

  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    className = elementReturnType.replaceFirst('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    // final elementType = [element.type.toString()];
    var instanceName = element.name;
    var types = TypeChecker.fromRuntime(OutputTypes)
            .annotationsOf(element)
            .first
            .getField("types")
            ?.toListValue()
            ?.map((e) => e.toStringValue()!)
            .toList() ??
        [];

    types.forEach((el) {
      settings[el] == null
          ? settings[el] = [instanceName]
          : settings[el]!.add(instanceName);
    });
  }
}
