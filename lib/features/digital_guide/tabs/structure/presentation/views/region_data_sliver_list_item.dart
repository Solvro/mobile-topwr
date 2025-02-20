class RegionDataSliverListItem {
  final String Function(int) text;
  final Future<void> Function(int index)? onTap;
  final int itemCount;

  RegionDataSliverListItem({
    required this.text,
    this.onTap,
    required this.itemCount,
  });
}
