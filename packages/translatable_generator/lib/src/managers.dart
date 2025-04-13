enum SolvroLocale { pl, en }

abstract interface class TranslationResults {
  String get translatedText;
}

abstract class RemoteTranslatableManager<T extends TranslationResults> {
  const RemoteTranslatableManager();

  Future<T> translate(String text, SolvroLocale from, SolvroLocale to);
}

abstract class LocalTranslatableManager<Local extends TranslationResults, Remote extends TranslationResults> {
  const LocalTranslatableManager();

  Future<Local?> getTranslation(int hash, SolvroLocale locale);

  Future<void> saveTranslation(Remote translation);
}

typedef ValidityCheck<T extends TranslationResults> = bool Function(T translation);

typedef HashFunction = String Function(String text);

class SolvroTranslator<Local extends TranslationResults, Remote extends TranslationResults> {
  final LocalTranslatableManager<Local, Remote> localTranslatableManager;
  final RemoteTranslatableManager<Remote> remoteTranslatableManager;
  final ValidityCheck<Local> validityCheck;
  final SolvroLocale sourceLocale;

  const SolvroTranslator.init({
    required this.localTranslatableManager,
    required this.remoteTranslatableManager,
    required this.validityCheck,
    required this.sourceLocale,
  });

  Future<String> translate(String text, SolvroLocale to) async {
    if (sourceLocale == to || text.trim().isEmpty || !RegExp("[a-zA-Z0-9]").hasMatch(text)) {
      return text;
    }

    final localTranslation = await localTranslatableManager.getTranslation(text.hashCode, to);
    if (localTranslation != null && validityCheck(localTranslation)) {
      return localTranslation.translatedText;
    }

    final remoteTranslation = await remoteTranslatableManager.translate(text, sourceLocale, to);
    await localTranslatableManager.saveTranslation(remoteTranslation);
    return remoteTranslation.translatedText;
  }
}
