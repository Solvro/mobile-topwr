import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/hex_color.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/loading_widget.dart';
import '../repositories/departments_repository.dart';

class DepartmentCard extends StatelessWidget {
  final Department? department;
  const DepartmentCard(this.department, {super.key});

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
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14.0, bottom: 14, left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  department!.code,
                  style: context.textTheme.headlineWhite,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(
                  width: 191,
                  child: Text(
                    '${context.localize!.department} ${department!.name}',
                    style: context.textTheme.bodyWhite,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CachedNetworkImage(
              maxWidthDiskCache: 108,
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
