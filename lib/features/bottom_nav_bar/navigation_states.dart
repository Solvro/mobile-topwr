import 'package:equatable/equatable.dart';

class NavigationStates extends Equatable {
  const NavigationStates({this.index = 0});

  final int index;

  NavigationStates copyWith({int? index}) {
    return NavigationStates(index: index ?? this.index);
  }

  @override
  List<Object?> get props => [index];
}