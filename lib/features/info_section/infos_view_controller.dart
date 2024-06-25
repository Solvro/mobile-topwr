import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'repository/get_infos_repository.dart';

part "infos_view_controller.g.dart";

@riverpod
class SearchInfosController extends _$SearchInfosController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@riverpod
Future<Iterable<Infos?>?> infosList(InfosListRef ref) async {
  final originalList = await ref.watch(infosRepositoryProvider.future);
  final query = ref.watch(searchInfosControllerProvider);
  return originalList?.where((element) =>
      element == null ||
      (element.name?.toLowerCase().contains(query.toLowerCase()) ?? false));
}
