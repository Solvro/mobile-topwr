import "dart:async";
import "dart:convert";
import "dart:io";
import "dart:ui" as ui;

import "package:crypto/crypto.dart";
import "package:flutter/material.dart" hide Image;
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";
import "package:sqflite_common_ffi/sqflite_ffi.dart";
import "package:widgetbook/src/test/font_loader.dart";
import "package:widgetbook/src/test/scenario_metadata.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_workspace/widgetbook_config.dart";
import "package:widgetbook_workspace/widgetbook_placeholders.dart";

const widgetbookTestViewport = ViewportData(
  name: "Widgetbook Test",
  width: 1200,
  height: 1800,
  pixelRatio: 1,
  platform: TargetPlatform.macOS,
);

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  final pluginTempDirectory = Directory.systemTemp.createTempSync("widgetbook_test_");
  final previousHttpOverrides = HttpOverrides.current;
  Uint8List? placeholderImageBytes;

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUpAll(() async {
    mockPathProvider(binding, pluginTempDirectory);
    placeholderImageBytes = await loadPlaceholderImageBytes();
    HttpOverrides.global = WidgetbookHttpOverrides(placeholderImageBytes ?? transparentPngBytes);
    await loadFonts();
  });

  tearDownAll(() {
    HttpOverrides.global = previousHttpOverrides;
    pluginTempDirectory.deleteSync(recursive: true);
  });

  testWidgetbook(config);
}

Future<Uint8List?> loadPlaceholderImageBytes() async {
  final placeholderFile = File.fromUri(Directory.current.uri.resolve("../../assets/png/app_icon.png"));
  try {
    return await placeholderFile.readAsBytes();
  } on FileSystemException {
    return null;
  }
}

void testWidgetbook(Config config) {
  for (final component in config.components) {
    group(component.name, () {
      for (final story in component.stories) {
        group(story.name, () {
          for (final scenario in story.allScenarios(config)) {
            testScenario(config, scenario);
          }
        });
      }
    });
  }
}

void testScenario(Config config, Scenario scenario) {
  final targetViewport = scenario.viewport ?? widgetbookTestViewport;

  testWidgets(scenario.name, (tester) async {
    tester.view.physicalConstraints = targetViewport.viewConstraints;
    tester.view.devicePixelRatio = targetViewport.pixelRatio;
    addTearDown(tester.view.reset);

    final semanticsHandle = tester.binding.ensureSemantics();
    try {
      final key = UniqueKey();
      await tester.pumpWidget(Builder(key: key, builder: (context) => scenario.buildWithConfig(context, config)));

      await scenario.execute(tester);

      final element = tester.element(find.byKey(key));
      final imageFuture = captureImage(element, 1);
      final semanticsNode = tester.getSemantics(find.byKey(key));

      final binding = TestWidgetsFlutterBinding.instance;
      await binding.runAsync(() async {
        final image = await imageFuture;
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        final imageBytes = byteData!.buffer.asUint8List();

        final metadata = ScenarioMetadata(
          scenario: scenario,
          imageBytes: imageBytes,
          imageWidth: image.width,
          imageHeight: image.height,
          pixelRatio: targetViewport.pixelRatio,
          semanticsData: semanticsTreeToJson(semanticsNode),
        );

        const jsonEncoder = JsonEncoder.withIndent("  ");
        await metadata.directory.create(recursive: true);
        await Future.wait([
          metadata.imageFile.writeAsBytes(imageBytes, flush: true),
          metadata.jsonFile.writeAsString(jsonEncoder.convert(metadata), flush: true),
        ]);

        image.dispose();
      });
    } finally {
      semanticsHandle.dispose();
    }
  });
}

Future<ui.Image> captureImage(Element element, double pixelRatio) {
  var renderObject = element.renderObject!;
  while (!renderObject.isRepaintBoundary) {
    renderObject = renderObject.parent!;
  }

  final layer = renderObject.debugLayer! as OffsetLayer;
  return layer.toImage(renderObject.paintBounds, pixelRatio: pixelRatio);
}

void mockPathProvider(TestWidgetsFlutterBinding binding, Directory directory) {
  const channel = MethodChannel("plugins.flutter.io/path_provider");
  final messenger = binding.defaultBinaryMessenger;

  messenger.setMockMethodCallHandler(channel, (call) async {
    return switch (call.method) {
      "getTemporaryDirectory" ||
      "getApplicationSupportDirectory" ||
      "getApplicationDocumentsDirectory" ||
      "getApplicationCacheDirectory" => directory.path,
      _ => null,
    };
  });
}

final transparentPngBytes = base64Decode(
  "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAACklEQVR4nGMAAQAABQABDQottAAAAABJRU5ErkJggg==",
);

class WidgetbookHttpOverrides extends HttpOverrides {
  WidgetbookHttpOverrides(this.placeholderBytes);

  final Uint8List placeholderBytes;

  @override
  HttpClient createHttpClient(SecurityContext? context) => WidgetbookHttpClient(placeholderBytes);
}

class WidgetbookHttpClient implements HttpClient {
  WidgetbookHttpClient(this.placeholderBytes);

  final Uint8List placeholderBytes;

  @override
  var autoUncompress = true;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => WidgetbookHttpClientRequest(url, placeholderBytes);

  @override
  void close({bool force = false}) {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class WidgetbookHttpClientRequest implements HttpClientRequest {
  WidgetbookHttpClientRequest(this.url, this.placeholderBytes);

  final Uri url;
  final Uint8List placeholderBytes;

  @override
  final headers = WidgetbookHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => WidgetbookHttpClientResponse(
    url == Uri.parse(widgetbookPlaceholderImageUrl) ? placeholderBytes : transparentPngBytes,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class WidgetbookHttpClientResponse extends Stream<List<int>> implements HttpClientResponse {
  WidgetbookHttpClientResponse(this.bytes);

  final Uint8List bytes;

  @override
  int get contentLength => bytes.length;

  @override
  final headers = WidgetbookHttpHeaders();

  @override
  final statusCode = HttpStatus.ok;

  @override
  final compressionState = HttpClientResponseCompressionState.notCompressed;

  @override
  final isRedirect = false;

  @override
  final persistentConnection = false;

  @override
  final reasonPhrase = "OK";

  @override
  final redirects = const <RedirectInfo>[];

  @override
  X509Certificate? get certificate => null;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.value(
      bytes,
    ).listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class WidgetbookHttpHeaders implements HttpHeaders {
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Map<String, dynamic> semanticsTreeToJson(SemanticsNode node) {
  final properties = node.getSemanticsData().toSafeJson();
  final children = <Map<String, dynamic>>[];

  node.visitChildren((child) {
    children.add(semanticsTreeToJson(child));
    return true;
  });

  properties["children"] = children;
  properties["hash"] = sha256.convert(utf8.encode(jsonEncode(properties))).toString();
  return properties;
}

extension on SemanticsData {
  Map<String, dynamic> toSafeJson() {
    final properties = <String, dynamic>{};

    if (!flagsCollection.hasDefaultValues) {
      properties["flagsCollection"] = flagsCollection.toSafeJson();
    }

    addInt(properties, "actions", actions);
    addString(properties, "identifier", identifier);
    addString(properties, "label", label);
    addString(properties, "value", value);
    addString(properties, "increasedValue", increasedValue);
    addString(properties, "decreasedValue", decreasedValue);
    addString(properties, "hint", hint);
    addString(properties, "tooltip", tooltip);
    addInt(properties, "headingLevel", headingLevel);
    addEnum(properties, "textDirection", textDirection);
    addNullableToString(properties, "textSelection", textSelection);
    addFiniteNum(properties, "scrollChildCount", scrollChildCount);
    addFiniteNum(properties, "scrollIndex", scrollIndex);
    addFiniteNum(properties, "scrollPosition", scrollPosition);
    addFiniteNum(properties, "scrollExtentMax", scrollExtentMax);
    addFiniteNum(properties, "scrollExtentMin", scrollExtentMin);
    addFiniteNum(properties, "platformViewId", platformViewId);
    addFiniteNum(properties, "maxValueLength", maxValueLength);
    addFiniteNum(properties, "currentValueLength", currentValueLength);
    addNullable(properties, "linkUrl", linkUrl);
    addRect(properties, "rect", rect);
    addCollection(properties, "tags", tags, (tag) => tag.name);
    addFiniteNumList(properties, "transform", transform?.storage);
    addCollection(properties, "customSemanticsActionIds", customSemanticsActionIds, (id) => id.toString());
    addEnum(properties, "role", role);
    addCollection(properties, "controlsNodes", controlsNodes);
    addEnum(properties, "validationResult", validationResult);
    addEnum(properties, "inputType", inputType);
    addNullableToString(properties, "locale", locale);

    return properties;
  }
}

extension on SemanticsFlags {
  Map<String, dynamic> toSafeJson() {
    final properties = <String, dynamic>{};

    addInt(properties, "isChecked", isChecked.value);
    addInt(properties, "isSelected", isSelected.value);
    addInt(properties, "isEnabled", isEnabled.value);
    addInt(properties, "isToggled", isToggled.value);
    addInt(properties, "isExpanded", isExpanded.value);
    addInt(properties, "isRequired", isRequired.value);
    addInt(properties, "isFocused", isFocused.value);
    addBool(properties, "isButton", isButton);
    addBool(properties, "isTextField", isTextField);
    addBool(properties, "isInMutuallyExclusiveGroup", isInMutuallyExclusiveGroup);
    addBool(properties, "isHeader", isHeader);
    addBool(properties, "isObscured", isObscured);
    addBool(properties, "scopesRoute", scopesRoute);
    addBool(properties, "namesRoute", namesRoute);
    addBool(properties, "isHidden", isHidden);
    addBool(properties, "isImage", isImage);
    addBool(properties, "isLiveRegion", isLiveRegion);
    addBool(properties, "hasImplicitScrolling", hasImplicitScrolling);
    addBool(properties, "isMultiline", isMultiline);
    addBool(properties, "isReadOnly", isReadOnly);
    addBool(properties, "isLink", isLink);
    addBool(properties, "isSlider", isSlider);
    addBool(properties, "isKeyboardKey", isKeyboardKey);

    return properties;
  }

  bool get hasDefaultValues {
    return isChecked.value == 0 &&
        isSelected.value == 0 &&
        isEnabled.value == 0 &&
        isToggled.value == 0 &&
        isExpanded.value == 0 &&
        isRequired.value == 0 &&
        isFocused.value == 0 &&
        !isButton &&
        !isTextField &&
        !isInMutuallyExclusiveGroup &&
        !isHeader &&
        !isObscured &&
        !scopesRoute &&
        !namesRoute &&
        !isHidden &&
        !isImage &&
        !isLiveRegion &&
        !hasImplicitScrolling &&
        !isMultiline &&
        !isReadOnly &&
        !isLink &&
        !isSlider &&
        !isKeyboardKey;
  }
}

void addString(Map<String, dynamic> properties, String key, String value) {
  if (value.isNotEmpty) properties[key] = value;
}

void addInt(Map<String, dynamic> properties, String key, int value) {
  if (value != 0) properties[key] = value;
}

// ignore: avoid_positional_boolean_parameters
void addBool(Map<String, dynamic> properties, String key, bool value) {
  if (value) properties[key] = value;
}

void addEnum(Map<String, dynamic> properties, String key, Enum? value) {
  if (value != null && value.index != 0) properties[key] = value.index;
}

void addNullable<T>(Map<String, dynamic> properties, String key, T? value) {
  if (value != null) properties[key] = value;
}

void addNullableToString<T>(Map<String, dynamic> properties, String key, T? value) {
  if (value != null) properties[key] = value.toString();
}

void addFiniteNum(Map<String, dynamic> properties, String key, num? value) {
  if (value != null && value.isFinite) properties[key] = value;
}

void addRect(Map<String, dynamic> properties, String key, Rect value) {
  final values = [value.left, value.top, value.right, value.bottom];
  if (!value.isEmpty && values.every((value) => value.isFinite)) {
    properties[key] = values;
  }
}

void addFiniteNumList(Map<String, dynamic> properties, String key, List<num>? values) {
  if (values != null && values.every((value) => value.isFinite)) {
    properties[key] = values;
  }
}

void addCollection<T>(
  Map<String, dynamic> properties,
  String key,
  Iterable<T>? collection, [
  dynamic Function(T)? map,
]) {
  if (collection != null && collection.isNotEmpty) {
    properties[key] = map != null ? collection.map(map).toList() : collection.toList();
  }
}
