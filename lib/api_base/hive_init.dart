import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initHiveForGraphqlCache() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) return;
  final appDir = await getApplicationDocumentsDirectory();
  final path = appDir.path;
  HiveStore.init(onPath: path);
}
