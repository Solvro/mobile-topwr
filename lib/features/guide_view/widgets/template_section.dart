import 'package:flutter/material.dart';

import '../../../widgets/my_cached_image.dart';

class GuideTemplateSection extends StatelessWidget {
  const GuideTemplateSection({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.onTap,
    this.titleTextStyle,
  });

  final String title;
  final String description;
  final String imagePath;
  final VoidCallback? onTap;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleTextStyle ??
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(description),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox.square(
                dimension: 50,
                child: MyCachedImage(imagePath),
              )
            ],
          ),
        ),
      ),
    );
  }
}
