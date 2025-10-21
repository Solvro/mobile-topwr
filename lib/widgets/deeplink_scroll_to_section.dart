import "dart:async";

import "package:flutter/material.dart";

class DeeplinkScrollToSection {
  DeeplinkScrollToSection({this.sectionId});

  final int? sectionId;

  final scrollController = ScrollController();
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

  void dispose() => scrollController.dispose();
}

// Wrapper widget to allow using DeeplinkScrollToSection in stateless widgets(less refactors)
class DeeplinkScrollToSectionWrapper extends StatefulWidget {
  const DeeplinkScrollToSectionWrapper({super.key, required this.builder, this.sectionId});

  final int? sectionId;
  final Widget Function(BuildContext, DeeplinkScrollToSection) builder;

  @override
  State<DeeplinkScrollToSectionWrapper> createState() => _DeeplinkScrollToSectionWrapperState();
}

class _DeeplinkScrollToSectionWrapperState extends State<DeeplinkScrollToSectionWrapper> {
  late final DeeplinkScrollToSection helper;

  @override
  void initState() {
    super.initState();
    helper = DeeplinkScrollToSection(sectionId: widget.sectionId);
  }

  @override
  void dispose() {
    helper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.builder(context, helper);
    if (helper.shouldScroll) {
      print("ADDING SCROLL");
      WidgetsBinding.instance.addPostFrameCallback((_) => helper.scrollToSection());
    }
    return w;
  }
}
