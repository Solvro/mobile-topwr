import "../../../../utils/generate_range.dart";
import "../models/hour_label.dart";

Iterable<HourLabel> generateRangeHourPoints(double start, double stop, [double step = 1]) =>
    generateRange(start, stop, step).map(HourLabel.new);
