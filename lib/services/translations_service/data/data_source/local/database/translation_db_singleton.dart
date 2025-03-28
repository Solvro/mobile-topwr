import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../translations_data_source.dart";

part "translation_db_singleton.g.dart";

@Riverpod(keepAlive: true)
TranslationsDataSource translationsDatabaseSingleton(Ref ref) => TranslationsDataSource();
