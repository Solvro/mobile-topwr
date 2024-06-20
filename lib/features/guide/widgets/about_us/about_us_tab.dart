import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../api_base/directus_assets_url.dart';
import '../../../../config/ui_config.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../widgets/my_error_widget.dart';
import '../../../study_circle_details/widgets/details_screen_app_bar.dart';
import '../../../study_circle_details/widgets/details_screen_sliver_header_section.dart';
import 'models/about_us_details.dart';
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
      AsyncLoading() => Center(
            child: CircularProgressIndicator(
          color: context.colorTheme.orangePomegranade,
        )),
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
                    members: AboutUsDetails().getMemberData(value?.aboutUsTeam),
                  ),
                  SectionHeader(text: context.localize.follow_solvro),
                  LinksSection(
                    links: AboutUsDetails().getSocialIcons(value?.aboutUs),
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
