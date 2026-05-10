import "package:flutter/widgets.dart";
import "package:intl/date_symbol_data_local.dart";
import "package:widgetbook/widgetbook.dart";

import "widgetbook_config.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runWidgetbook(config);
}
