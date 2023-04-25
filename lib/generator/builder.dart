import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';

Builder generateLogger(BuilderOptions options) =>
    SharedPartBuilder([LoggerGenerator()], 'logger_generator');
