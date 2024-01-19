import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/hex_color.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/my_cached_image.dart';
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
            HexColor(department?.color?.gradientSecond ?? DepartmentsConfig.defaultColorFirst),
            HexColor(department?.color?.gradientFirst ?? DepartmentsConfig.defaultColorSecond),
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
            child: MyCachedImage(department?.logo?.url)
          ),
        ],
      ),
    );
  }
}
