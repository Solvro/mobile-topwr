import 'package:flutter/material.dart';

import '../../../repositories/getDepartments.graphql.dart';
import '../../../theme/app_theme.dart';

class DepartmentBox extends StatelessWidget {
  final Query$GetDepartments$departments? department;
  const DepartmentBox(
      {super.key, this.department});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.green,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
        ),
      ),
    );
  }
}
