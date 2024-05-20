import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


final locationPermissionStatusProvider = FutureProvider<bool>((ref) {
  return Permission.location.status.then((status) {
    if (!status.isGranted) {
      return Permission.location.request().then((_) => Permission.location.status.isGranted);
    } else {
      return Future.value(status.isGranted);
    }
  });
});

