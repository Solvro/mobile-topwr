import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/hex_color.dart';
import '../repositories/departments_repository.dart';

class DepartmentBox extends StatelessWidget {
  final Department department;
  const DepartmentBox(this.department, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              HexColor(department.color?.gradientSecond ??
                  DepartmentBoxConfig.defaultColorFirst),
              HexColor(department.color?.gradientFirst ??
                  DepartmentBoxConfig.defaultColorSecond),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    department.logo?.url ?? DepartmentBoxConfig.defaultUrl,
                color: Colors.white.withOpacity(.12),
                fit: BoxFit.cover,
                height: double.infinity,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    department.code,
                    style: context.textTheme.titleWhite,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Wydział ${department.name}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyWhite,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
