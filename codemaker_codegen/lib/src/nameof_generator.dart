import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:codemaker_annotations/codemaker_annotations.dart';
import 'package:codemaker_codegen/src/model_visiter.dart';
import 'package:source_gen/source_gen.dart';

class NameOfGenerator extends GeneratorForAnnotation<NameOfAnnotation> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final buffer = StringBuffer();
    buffer.writeln(
        "String ${visitor.className.toLowerCase()}TableName = '${visitor.className}';");
    buffer.writeln('class NameOf${visitor.className}{');
    for (var field in visitor.fields.keys) {
      buffer.writeln("static String get $field => '$field';");
    }
    buffer.writeln(
        "static Map<String, Type> get nameAndTypeOf${visitor.className}Map => <String, Type>{${visitor.fields.entries.fold("", (previousValue, element) => "${element.key}:${element.value}, $previousValue")}};");
    buffer.writeln('}');

    buffer.writeln('class TypeOf${visitor.className}{');
    for (var field in visitor.fields.entries) {
      buffer.writeln("static Type get ${field.key} => ${field.value};");
    }
    buffer.writeln('}');

    return buffer.toString();
  }
}
