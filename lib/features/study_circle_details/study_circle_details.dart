import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/loading_widgets/my_loading_widget.dart';
import 'study_circle_details_contact_section.dart';
import '../../utils/context_extensions.dart';
import '../../widgets/my_error_widget.dart';
import 'study_circle_details_repository/study_circle_repository.dart';
import 'study_circle_details_header.dart';
import '../../theme/app_theme.dart';

class StudyCircleDetails extends ConsumerWidget {
  const StudyCircleDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    final state = ref.watch(studyCircleRepositoryProvider(itemId));

    return switch (state) {
      AsyncLoading() => const LoadingWidget(),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  '< ${context.localize!.study_circles}',
                  style: context.textTheme.boldBodyOrange,
                )),
          ),
          body: ListView(
            children: [
              StudyCircleDetailsHeader(
                logoImageUrl: value?.photo?.url ?? '',
                title: value?.name ?? '',
                backgroundImageUrl: value?.backgroundPhoto?.url ?? '',
                department: value?.department?.name ?? '',
              ),
              const SizedBox(height: 16),
              ContactSection(
                list: value?.infoSection
                        ?.expand((e) => e?.info ?? [])
                        .map((a) => ContactSectionData(
                              iconUrl: a?.icon?.url,
                              text: a?.visibleText,
                              url: a?.value,
                            ))
                        .toList() ??
                    List.empty(),
              ),
              const SizedBox(height: 16),
              AboutUsSection(
                text: value?.description ?? '',
              ),
            ],
          ),
        ),
    };
  }
}

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return
      text.isEmpty ? const SizedBox.shrink() :
      Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.localize!.about_us, style: context.textTheme.headline),
          const SizedBox(height: 16),
          Text(text, style: context.textTheme.body),
        ],
      ),
    );
  }
}
