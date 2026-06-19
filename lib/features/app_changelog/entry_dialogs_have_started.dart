import "package:riverpod_annotation/riverpod_annotation.dart";

part "entry_dialogs_have_started.g.dart";

@Riverpod(keepAlive: true)
class EntryDialogsHaveStarted extends _$EntryDialogsHaveStarted {
  @override
  bool build() => false;

  void markStarted() {
    state = true;
  }
}
