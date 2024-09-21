import "package:flutter_hooks/flutter_hooks.dart";

void useEffectOnInit(void Function()? Function() effect) {
  useEffect(
    effect,
    const [], // empty dependencies list; meaning it will only run once, on first build (like initState a bit)
  );
}
