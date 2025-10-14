import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../widgets/my_text_button.dart";
import "../../../../widgets/search_box_app_bar.dart";
import "../data/models/sks_menu_data.dart";
import "../data/repository/sks_menu_subscription_repository.dart";
import "widgets/sks_menu_section.dart";
import "widgets/sks_menu_subscriptions_dishes_sections.dart";

@RoutePage()
class SksMenuSubscriptionsView extends ConsumerWidget {
  const SksMenuSubscriptionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(sksMenuSubscriptionRepositoryProvider);
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: SearchBoxAppBar(
        context,
        addLeadingPopButton: true,
        title: context.localize.guide,
        onQueryChanged: (searchQuery) {},
        onSearchBoxTap: () {},
      ),
      body: switch (asyncData) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncData(value: (final subscribedMeals, final unsubscribedMeals)) => _SksMenuSubscriptionsView(
          subscribedMeals: subscribedMeals,
          unsubscribedMeals: unsubscribedMeals,
        ),
        _ => const Text("Error: "),
      },
    );
  }
}

class _SksMenuSubscriptionsView extends StatelessWidget {
  const _SksMenuSubscriptionsView({required this.subscribedMeals, required this.unsubscribedMeals});

  final IList<SksMenuDish> subscribedMeals;
  final IList<SksMenuDish> unsubscribedMeals;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SksMenuConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Choose the meals you want to receive notifications for when they appear on the menu. To select a meal from the unsubscribed section, tap on it. Seselecting works the same way.",
          ),
          const Divider(indent: SksMenuConfig.paddingSmall, endIndent: SksMenuConfig.paddingLarge),
          const Text("Subscribed meals"),
          Expanded(child: SubscribedMealsSection(meals: subscribedMeals)),
          const Divider(indent: SksMenuConfig.paddingSmall, endIndent: SksMenuConfig.paddingLarge),
          const Text("Not subscribed meals"),
          Expanded(flex: 2, child: SingleChildScrollView(child: SksMenuSection(unsubscribedMeals))),
          MyTextButton(actionTitle: context.localize.sks_menu_vegetarian_dishes, showBorder: true, onClick: () {}),
        ],
      ),
    );
  }
}
