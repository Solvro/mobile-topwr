import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "navigation_stack.g.dart";

@Riverpod(keepAlive: true)
class NavigationStack extends _$NavigationStack {
  @override
  IList<Route<dynamic>> build() {
    return const IList.empty();
  }

  void setStack(IList<Route<dynamic>> value) {
    state = value;
  }
}

@riverpod
Route<dynamic>? currentRoute(Ref ref) {
  final stack = ref.watch(navigationStackProvider);
  if (stack.isEmpty) {
    return null;
  }
  return stack.last; // top most route
}

@riverpod
Route<dynamic>? previousRoute(Ref ref) {
  final stack = ref.watch(navigationStackProvider);
  if (stack.length <= 1) {
    return null;
  }
  return stack.removeLast().last; // second top most route
}

@riverpod
bool isStackPoppable(Ref ref) {
  return ref.watch(navigationStackProvider).length > 1;
}

/*
  This class is used to observe the navigation stack
  Acts as a bridge between navigator and riverpod state notifier
*/
class NavigationObserver extends NavigatorObserver {
  final WidgetRef ref;

  NavigationObserver(this.ref);

  /*
  This 2 methods sync observer with the riverpod state
  */
  void setStack(IList<Route<dynamic>> value) {
    Future.microtask(() => ref.read(navigationStackProvider.notifier).setStack(value));
  }

  IList<Route<dynamic>> get stack => ref.read(navigationStackProvider);

  /*
  This 4 methods sync observer with the actual navigation stack
  */
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    setStack(stack.removeLast());
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    setStack(stack.add(route));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    setStack(stack.removeLast().add(newRoute!));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    setStack(stack.removeLast());
  }
}
