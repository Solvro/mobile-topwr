import "package:flutter/material.dart";

@immutable
class IconViewName {
  final String name;
  final Widget icon;

  const IconViewName({required this.name, required this.icon});

  @override
  bool operator ==(Object other) => identical(this, other) || other is IconViewName && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
