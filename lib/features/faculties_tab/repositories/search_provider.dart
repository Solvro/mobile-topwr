import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class SearchTextController extends _$SearchTextController {
  @override 
  String build() => "";

  void onTextChanged(String newValue){
    state = newValue;
  }

}