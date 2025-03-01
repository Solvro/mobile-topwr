import "package:flutter/material.dart";
import "package:wiredash/wiredash.dart";

import "../../../theme/colors.dart";
import "../utils/context_extensions.dart";

extension WiredashConfigX on BuildContext {
  List<Label> get labels => [
    Label(id: "label-a9v91o7kdq", title: localize.new_feature),
    Label(id: "label-bekp7mkn82", title: localize.bug),
    Label(id: "label-ykl4o5vddu", title: localize.praise),
  ];
  WiredashThemeData get wiredashTheme => WiredashThemeData(
    primaryColor: ColorsConsts.orangePomegranade,
    secondaryColor: ColorsConsts.blueAzure,
    primaryBackgroundColor: ColorsConsts.whiteSoap,
    secondaryBackgroundColor: ColorsConsts.whiteSoap,
    appBackgroundColor: ColorsConsts.blackMirage,
    appHandleBackgroundColor: ColorsConsts.greyPigeon,
    firstPenColor: ColorsConsts.orangePomegranade,
    secondPenColor: ColorsConsts.blueAzure,
    thirdPenColor: ColorsConsts.greyPigeon,
    fourthPenColor: ColorsConsts.blackMirage,
    errorColor: ColorsConsts.orangePomegranade,
    primaryContainerColor: ColorsConsts.blueAzure,
    textOnPrimaryContainerColor: ColorsConsts.whiteSoap,
    secondaryContainerColor: ColorsConsts.greyLight,
    textOnSecondaryContainerColor: ColorsConsts.blackMirage,
  );
}
