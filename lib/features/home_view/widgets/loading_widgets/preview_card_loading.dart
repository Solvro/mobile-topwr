import 'package:flutter/material.dart';
import '../../../../widgets/loading_widgets/shimmer_loading.dart';

class PreviewCardLoading extends StatelessWidget {
  const PreviewCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmeringEffect(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
