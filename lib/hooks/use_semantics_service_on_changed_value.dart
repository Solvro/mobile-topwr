import "package:flutter/semantics.dart";
import "package:flutter_hooks/flutter_hooks.dart";

void useSemanticsServiceOnChangedValue<T>(T value, {required String Function(T value) messageBuilder}) {
  final isFirstRender = useRef(true);

  useEffect(() {
    if (isFirstRender.value) {
      isFirstRender.value = false;
      return null;
    }
    Future.microtask(() async {
      await SemanticsService.announce(messageBuilder(value), TextDirection.ltr);
    });
    return null;
  }, [value]);
}
