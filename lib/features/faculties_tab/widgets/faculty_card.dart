import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../repositories/getDepartments.graphql.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/loading_widget.dart';

class FacultyCard extends StatelessWidget {
  final Query$GetDepartments$departments? faculty;
  const FacultyCard({super.key, required this.faculty});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(

          colors: [Colors.blue, Colors.green],
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  faculty!.code,
                  style: context.textTheme.headlineWhite,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  faculty!.name,
                  style: context.textTheme.bodyWhite,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CachedNetworkImage(
              imageUrl:
                  'https://p1.hiclipart.com/preview/209/923/667/google-logo-background-g-suite-google-pay-google-doodle-text-circle-line-area-png-clipart.jpg',
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const LoadingWidget(),
              errorWidget: (context, url, error) => ErrorWidget(error),
            ),
          ),
        ],
      ),
    );
  }
}
