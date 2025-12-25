import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class DeeplinkScrollToSection {
  DeeplinkScrollToSection({required this.scrollController, this.sectionId});

  final int? sectionId;
  final ScrollController scrollController;
  final Map<int, GlobalKey> _sectionKeys = {};

  void registerSections(Iterable<int> ids) {
    for (final id in ids) {
      _sectionKeys[id] = GlobalKey();
    }
  }

  GlobalKey? keyFor(int id) => _sectionKeys[id];

  void scrollToSection({Duration duration = const Duration(milliseconds: 600)}) {
    if (sectionId == null) return;
    final key = _sectionKeys[sectionId];
    if (key == null || key.currentContext == null) return;

    unawaited(Scrollable.ensureVisible(key.currentContext!, duration: duration, curve: Curves.easeInOut));
  }

  bool get shouldScroll => sectionId != null && sectionId! > 0 && _sectionKeys.containsKey(sectionId);
}

// Wrapper widget to allow using DeeplinkScrollToSection in stateless widgets(less refactors)
class DeeplinkScrollToSectionWrapper extends HookWidget {
  const DeeplinkScrollToSectionWrapper({super.key, required this.builder, this.sectionId});

  final int? sectionId;
  final Widget Function(BuildContext, DeeplinkScrollToSection) builder;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final helper = useMemoized(
      () => DeeplinkScrollToSection(scrollController: scrollController, sectionId: sectionId),
      [sectionId],
    );

    final w = builder(context, helper);
    if (helper.shouldScroll) {
      WidgetsBinding.instance.addPostFrameCallback((_) => helper.scrollToSection());
    }
    return w;
  }
}
