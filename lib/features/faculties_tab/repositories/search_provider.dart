import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final searchControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());
