import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/hex_color.dart';
import '../../../widgets/loading_widget.dart';
import '../repositories/getDepartments.graphql.dart';

class DepartmentCard extends StatelessWidget {
  final Query$GetDepartments$departments? department;
  const DepartmentCard({super.key, required this.department});


  String cutText(String text) {
    if (text.length > 28) {
      int currentIndex = 0;
      int lastSpace = 0;
      while (currentIndex < text.length) {
        if (text[currentIndex] == ' ') {
          lastSpace = currentIndex;
        }
        currentIndex++;
      }
      return '${text.substring(0,lastSpace)}\n${text.substring(lastSpace+1)}';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor(department?.color?.gradientSecond ?? '#BFBEBE'),
            HexColor(department?.color?.gradientFirst ?? '#BFBEBE'),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  department!.code,
                  style: context.textTheme.headlineWhite,
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  cutText(department!.name),
                  style: context.textTheme.bodyWhite,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CachedNetworkImage(
              imageUrl: department?.logo?.url ??
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const LoadingWidget(),
              errorWidget: (context, url, error) => ErrorWidget(error),
              color: Colors.white.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }
}
