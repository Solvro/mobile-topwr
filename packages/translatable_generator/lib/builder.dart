import "package:build/build.dart";
import "package:source_gen/source_gen.dart";
import "src/translator_generator.dart";

Builder translatableBuilder(BuilderOptions options) =>
    LibraryBuilder(TranslatableGenerator(), generatedExtension: ".translatable.g.dart");
