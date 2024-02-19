import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/my_cached_image.dart';

class StudyCircleDetailsHeader extends StatelessWidget {
  const StudyCircleDetailsHeader(
      {super.key,
        required this.logoImageUrl,
        required this.title,
        required this.department, required this.backgroundImageUrl});

  final String logoImageUrl;
  final String backgroundImageUrl;
  final String title;
  final String department;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SizedBox(height: 250, width : double.maxFinite, child: MyCachedImage(backgroundImageUrl)),
            Positioned(
              top: 185,
              child: Card(
                elevation: 3,
                shape: const CircleBorder(),
                child: SizedBox(
                    width: 130,
                    height: 130,
                    child: ClipOval(child: MyCachedImage(logoImageUrl))
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 84),
        Text(title, style: context.textTheme.headline),
        const SizedBox(height: 12),
        Text(department, style: context.textTheme.body)
      ],
    );
  }
}