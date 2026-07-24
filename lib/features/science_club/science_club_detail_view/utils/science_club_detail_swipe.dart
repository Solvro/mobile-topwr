import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "../../science_clubs_view/model/science_clubs.dart";

typedef DetailSwipeController = ({
  PageController controller,
  PointerDownEventListener onPointerDown,
  PointerUpEventListener onPointerUp,
  PointerCancelEventListener onPointerCancel,
});

DetailSwipeController useDetailSwipe(IList<ScienceClub> clubList, int initialIndex) {
  final pageController = useMemoized(() => PageController(initialPage: initialIndex));
  useEffect(() => pageController.dispose, []);
  final dragStart = useRef<Offset?>(null);
  final isBouncing = useRef(false);

  bool isValidSwipe(double dx, double dy) => dx.abs() > 40 && dx.abs() > dy.abs() * 2.0;

  void navigateTo(int page) {
    unawaited(pageController.animateToPage(page, duration: const Duration(milliseconds: 150), curve: Curves.easeInOut));
  }

  void bounceAtEdge(double dx) {
    isBouncing.value = true;
    final extent = pageController.position.maxScrollExtent;
    final target = dx > 0 ? -25.0 : extent + 25.0;
    final snapBack = dx > 0 ? 0.0 : extent;
    unawaited(
      pageController.animateTo(target, duration: const Duration(milliseconds: 100), curve: Curves.easeIn).then((_) {
        if (!pageController.hasClients) return;
        unawaited(
          pageController.animateTo(snapBack, duration: const Duration(milliseconds: 200), curve: Curves.easeOut).then((
            _,
          ) {
            if (!pageController.hasClients) return;
            isBouncing.value = false;
          }),
        );
      }),
    );
  }

  void onPointerDown(PointerDownEvent event) {
    dragStart.value = event.position;
  }

  void onPointerUp(PointerUpEvent event) {
    final start = dragStart.value;
    dragStart.value = null;
    if (start == null || isBouncing.value) return;

    final dx = event.position.dx - start.dx;
    final dy = event.position.dy - start.dy;
    if (!isValidSwipe(dx, dy)) return;

    final currentPage = pageController.page?.round() ?? initialIndex;
    final nextPage = dx < 0 ? currentPage + 1 : currentPage - 1;

    if (nextPage >= 0 && nextPage < clubList.length) {
      navigateTo(nextPage);
    } else {
      bounceAtEdge(dx);
    }
  }

  void onPointerCancel(PointerCancelEvent event) {
    dragStart.value = null;
  }

  return (
    controller: pageController,
    onPointerDown: onPointerDown,
    onPointerUp: onPointerUp,
    onPointerCancel: onPointerCancel,
  );
}
