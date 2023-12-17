import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initHiveForGraphqlCache() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) return;
  var appDir = await getApplicationDocumentsDirectory();
  var path = appDir.path;
  HiveStore.init(onPath: path);
}
