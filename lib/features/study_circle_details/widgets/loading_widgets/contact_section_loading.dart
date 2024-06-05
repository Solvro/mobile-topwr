import 'package:flutter/material.dart';
import '../../../../config/ui_config.dart';
import '../../../../theme/app_theme.dart';
import '../../../../widgets/loading_widgets/shimmer_loading.dart';

class ContactSectionLoading extends StatelessWidget {
  const ContactSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 8),
      color: context.colorTheme.greyLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoadingItem(
            child: Container(
              height: 24, //36
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: DetailsScreenConfig.spacerHeight),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: double.maxFinite,
              height: 116,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return const _IconWithUrlLoading();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                      height: DetailsScreenConfig.spacerHeight);
                },
                itemCount: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconWithUrlLoading extends StatelessWidget {
  const _IconWithUrlLoading();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerLoadingItem(
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ShimmerLoadingItem(
            child: Container(
              height: 24,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
