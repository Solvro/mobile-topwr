import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../widgets/my_error_widget.dart";
import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../utils/launch_url_util.dart";
import "../../widgets/search_box_app_bar.dart";
import "../../widgets/wide_tile_card.dart";
import "../analytics/data/clarity.dart";
import "../analytics/data/clarity_events.dart";
import "../departments/departments_view/widgets/departments_view_loading.dart";
import "data/models/guide_data.dart";
import "guide_view_controller.dart";
import "widgets/guide_grid.dart";
import "widgets/guide_tile.dart";

@RoutePage()
class GuideView extends StatelessWidget {
  const GuideView({super.key});

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.guide);
  }

  @override
  Widget build(BuildContext context) {
    return const _GuideView();
  }
}

class _GuideView extends HookConsumerWidget {
  const _GuideView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialQuery = context.routeData.parent?.queryParams.optString("qGuide");
    useEffect(() {
      if (initialQuery != null && initialQuery.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(searchGuideControllerProvider.notifier).onTextChanged(initialQuery);
        });
      }
      return null;
    }, [initialQuery]);

    return Semantics(
      label: context.localize.guide_view_description,
      child: Scaffold(
        appBar: SearchBoxAppBar(
          context,
          title: context.localize.guide,
          initialQuery: initialQuery,
          onQueryChanged: ref.watch(searchGuideControllerProvider.notifier).onTextChanged,
          onSearchBoxTap: () {
            unawaited(ref.trackEvent(ClarityEvents.searchGuideArticles));
          },
        ),
        body: const _GuideViewContent(),
      ),
    );
  }
}

class _GuideViewContent extends ConsumerWidget {
  const _GuideViewContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guideList = ref.watch(guideListControllerProvider);

    return switch (guideList) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final IList<GuideData> value) => GuideGrid(
        children: [
          for (final item in value) GuideTile(item),
          _GuideInfo(emailAddress: "kn.solvro@pwr.edu.pl", subject: context.localize.guide_subject_default_content),
        ].lock,
      ),
      _ => const Padding(padding: GuideViewConfig.gridPadding, child: DepartmentsViewLoading()),
    };
  }
}

class _GuideInfo extends ConsumerWidget {
  final String emailAddress;
  final String? subject;
  late final Uri emailLaunchUri;

  _GuideInfo({required this.emailAddress, this.subject}) {
    emailLaunchUri = Uri(scheme: "mailto", path: emailAddress, query: "subject=$subject");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WideTileCard(
      title: context.localize.hi_student,
      subtitle: context.localize.guide_ideas_info,
      trailing: SizedBox(
        height: context.textScaler.scale(WideTileCardConfig.imageSize),
        width: WideTileCardConfig.imageSize,
        child: Icon(Icons.lightbulb_outline, size: context.textScaler.scale(55), color: context.colorScheme.tertiary),
      ),
      onTap: () async {
        await ref.launch(emailLaunchUri.toString());
      },
    );
  }
}
