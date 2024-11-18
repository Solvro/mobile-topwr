import "package:flutter/material.dart";

import "../features/parking_chart/utils/range_hour_points.dart";
import "../theme/hex_color.dart";

abstract class MyAppConfig {
  static const title = "ToPWR";
  static const legalese =
      "\u{a9} 2024 Koło Naukowe Solvro, Politechnika Wrocławska";
}

abstract class SplashScreenConfig {
  static const additionalWaitDuration = Duration(seconds: 1);
  static const animationDuration = Duration(milliseconds: 800);
  static const androidSplashSizeInDp = 288.0;
  static const androidNativeSplashColor = Color(0xFFEE6644);
}

abstract class CountdownConfig {
  static const defaultDigit = 0;
}

abstract class DepartmentsConfig {
  static const defaultColorFirst = "#BFBEBE";
  static const defaultColorSecond = "#999898";

  static const listSeparatorSize = 16.0;
  static const logoMicroPadding = 10.0;

  static const departmentsViewGridDelegate =
      SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 600,
    mainAxisExtent: 92,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
  );
}

abstract class DateChipConfig {
  static const dateTimeFormat = "dd.MM.yyyy";
}

abstract class HomeViewConfig {
  static const paddingSmall = 6.0;
  static const paddingMedium = 16.0;
  static const bottomPadding = 24.0;

  static const squareCardTextShadow = [
    Shadow(
      color: HexColor.consts(0x6621334D66),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
}

abstract class BigPreviewCardConfig {
  static const cardHeight = 360.0;
  static const cardWidth = 240.0;
  static const defaultCrossAxisForcedSize = 220.0;
}

abstract class SearchBoxConfig {
  static const height = 36.0;
}

abstract class WideTileCardConfig {
  static const basePadding = 16.0;
  static const titlesSpacing = 8.0;
  static const minWidthForExtraPadding = 375;
  static const extraPaddingFactor = 0.33;

  static const imageSize = 92.0;
  static const radius = Radius.circular(8);

  static const defaultActiveShadows = [
    BoxShadow(
      color: Color.fromRGBO(250, 100, 101, 0.16),
      blurRadius: 11,
      spreadRadius: 6,
    ),
  ];
}

abstract class DetailViewsConfig {
  static const double spacerHeight = 16;
}

abstract class DetailViewsHeaderConfig {
  static const double logoSize = 130;
}

abstract class ScienceClubsViewConfig {
  static const source = "manual_entry";
  static const listSeparatorSize = 16.0;
  static const microPadding = 4.0;
  static const smallPadding = 16.0;
  static const mediumPadding = 24.0;

  static const buttonBorderRadius = 100.0;

  static const researchGroupTabGridDelegate =
      SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 600,
    mainAxisExtent: 92,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
  );

  static const tagsGridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 85,
    mainAxisExtent: 40,
    crossAxisSpacing: 4,
    mainAxisSpacing: 4,
  );
}

abstract class ScienceClubCardConfig {
  static const trailingPadding = 2.0;
}

abstract class ParkingsConfig {
  static const padding = EdgeInsets.only(
    left: 13,
    top: 10,
    bottom: 15,
    right: 10,
  );
  static const extraIndentPadd = EdgeInsets.only(left: 2, right: 40);
}

abstract class ParkingChartConfig {
  static final showLabels = generateRangeHourPoints(6, 22, 2).toList();
  static final showDots = generateRangeHourPoints(5, 22).toList();
}

abstract class AboutUsConfig {
  static const defaultLogoUrl = "f0311a7b-8838-4f48-bbcd-9791549012b1.png";
  static const defaultPadding = 16.0;
  static const spacerHeight = 24.0;
  static const borderRadius = 8.0;
  static const iconPadding = 10.0;
  static const photoSize = 92.0;

  static const dialogHorizontalPadding = 14.0;
  static const dialogVerticalPadding = 20.0;
  static const dialogButtonFontSize = 16.0;
  static const dialogTitleFontSize = 24.0;
}

abstract class GuideDetailViewConfig {
  static const paddingSmall = 4.0;
  static const paddingMedium = 16.0;
  static const paddingLarge = 32.0;
  static const borderRadius = 8.0;
  static const bottomPadding = 24.0;
}

abstract class GuideViewConfig {
  static const gridPadding = EdgeInsets.only(left: 24, right: 24, bottom: 24);
}

abstract class FilterConfig {
  static const bottomSheetHeightFactor = 0.65;
  static const searchFilterPadding = 15.0;
  static const paddingMedium = 8.0;
  static const spacingBetweenWidgets = 12.0;
  static final radius = BorderRadius.circular(8);
}

abstract class LottieAnimationConfig {
  static const frameRate = 120.0;
}

abstract class MyTooltipConfig {
  static const borderRadius = 8.0;

  static const defaultActiveShadows = [
    BoxShadow(
      color: Color.fromRGBO(250, 100, 101, 0.16),
      blurRadius: 11,
      spreadRadius: 6,
    ),
  ];
}

abstract class SksMenuConfig {
  static const borderRadius = 8.0;
  static const paddingSmall = 8.0;
  static const paddingLarge = 16.0;
  static const sksDataSource = "https://sks.pwr.edu.pl/menu";
}

abstract class SksConfig {
  static const sizedBoxWidth = 5.0;
  static const radius = 8.0;
  static const innerPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  static const outerPadding = EdgeInsets.only(right: 12, bottom: 2);
}
