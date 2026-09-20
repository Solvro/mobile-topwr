import "package:flutter_test/flutter_test.dart";

import "package:topwr/features/remote_config/data/models/remote_config.dart";

void main() {
  test("parses the backend kill switch", () {
    final config = RemoteConfig.fromJson({
      "cmsReferenceNumber": 1,
      "daySwapLookahead": 7,
      "translatorReferenceNumber": 1,
      "killswitchOfDoomAndDespair": true,
    });

    expect(config.killswitchOfDoomAndDespair, isTrue);
  });
}
