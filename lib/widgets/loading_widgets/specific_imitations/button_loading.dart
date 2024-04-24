import 'package:flutter/material.dart';
import '../shimmer_loading.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        linearGradient: shimmerGradient,
        child: Column(
          children: [
            ShimmerLoadingItem(
              child: Container(
                width: 110,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ));
  }
}
