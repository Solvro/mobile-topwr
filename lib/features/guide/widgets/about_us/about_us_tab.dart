import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../api_base/directus_assets_url.dart';
import '../../../../config/ui_config.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../utils/where_non_null_iterable.dart';
import '../../../../widgets/my_error_widget.dart';
import '../../../study_circle_details/widgets/details_screen_app_bar.dart';
import '../../../study_circle_details/widgets/details_screen_sliver_header_section.dart';
import 'models/link_data.dart';
import 'models/member_data.dart';
import 'repository/about_us_repository.dart';
import 'widgets/desription_section.dart';
import 'widgets/links_section.dart';
import 'widgets/section_header.dart';
import 'widgets/team_section.dart';

class AboutUsTab extends StatelessWidget {
  const AboutUsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailsScreenAppBar(context, title: context.localize.guide),
      body: const _AboutUsView(),
    );
  }
}

class _AboutUsView extends ConsumerWidget {
  const _AboutUsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aboutUsRepositoryProvider);

    return switch (state) {
      AsyncLoading() => const CircularProgressIndicator(),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SliverHeaderSection(
                logoImageUrl: AboutUsConfig.defaultLogoUrl,
                backgroundImageUrl:
                    value?.aboutUs?.cover?.filename_disk?.directusUrl,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SectionHeader(text: context.localize.about_us),
                  DescriptionSection(text: value?.aboutUs?.description ?? ''),
                  SectionHeader(text: context.localize.meet_out_team),
                  TeamSection(
                    members: value?.aboutUsTeam?.whereNonNull
                            .toList()
                            .map(
                              (e) => MemberData(
                                  socialLinks: e.socialLinks?.whereNonNull
                                          .toList()
                                          .map((e) => e.url)
                                          .toList() ??
                                      List.empty(),
                                  name: e.name,
                                  subtitle: e.subtitle,
                                  imageUrl: e.photo?.filename_disk ?? ''),
                            )
                            .toList() ??
                        List.empty(),
                  ),
                  SectionHeader(text: context.localize.follow_solvro),
                  LinksSection(
                    links: value?.aboutUs?.solvroSocialLinks.whereNonNull
                            .map(
                              (e) => LinkData(url: e.url),
                            )
                            .toList() ??
                        List.empty(),
                  ),
                  const SizedBox(
                    height: AboutUsConfig.spacerHeight,
                  )
                ],
              ),
            ),
          ],
        ),
    };
  }
}
