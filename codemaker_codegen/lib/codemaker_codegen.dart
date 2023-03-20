library codemaker_codegen;

import 'package:build/build.dart';
import 'package:codemaker_codegen/src/nameof_generator.dart';
import 'package:source_gen/source_gen.dart';

export './src/model_visiter.dart';
export './src/nameof_generator.dart';

Builder generateNameOfClass(BuilderOptions options) => SharedPartBuilder(
      [NameOfGenerator()],
      'nameof_generator',
    );
