import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../repositories/getDepartments.graphql.dart';
import '../../../theme/app_theme.dart';

class DepartmentBox extends StatelessWidget {
  final Query$GetDepartments$departments? department;
  const DepartmentBox({super.key, this.department});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              Colors.green,
              Colors.blue,
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
                imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
                color: Colors.white.withOpacity(.12),
                fit: BoxFit.cover,
                height: double.infinity,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    department!.code,
                    style: context.textTheme.titleWhite,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    department!.name.length > 32
                        ? '${department!.name.substring(0, 28)}...'
                        : department!.name,
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
