import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  Map<String, String> fields = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType.replaceFirst('*', '');
    if (element.periodOffset == null && element.isFactory) {
      for (var element in element.parameters) {
        fields[element.name] =
            element.type.getDisplayString(withNullability: false);
      }
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    fields[element.name] = element.type.toString().replaceFirst('*', '');
  }
}
