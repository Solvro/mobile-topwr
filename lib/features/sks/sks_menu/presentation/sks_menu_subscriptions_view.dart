import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../widgets/search_box_app_bar.dart";
import "../data/models/sks_menu_data.dart";
import "../data/repository/sks_menu_subscription_repository.dart";
import "widgets/sks_menu_section.dart";
import "widgets/sks_menu_subscriptions_subscribed_dishes.dart";

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
        title: context.localize.sks_menu_subscriptions,
        onQueryChanged: (searchQuery) {},
        onSearchBoxTap: () {},
        primary: true,
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
      padding: const EdgeInsets.symmetric(horizontal: SksMenuConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.only(bottom: SksMenuConfig.paddingMedium),
            child: Text(context.localize.sks_menu_subscribed_dishes, style: context.textTheme.titleOrange),
          ),
          Expanded(child: SksMenuSubscriptionSubscribedDishes(meals: subscribedMeals)),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(vertical: SksMenuConfig.paddingMedium),
            child: Text(
              context.localize.sks_menu_dishes_available_for_subscription,
              style: context.textTheme.titleOrange,
            ),
          ),
          Expanded(flex: 2, child: SingleChildScrollView(child: SksMenuSection(unsubscribedMeals))),
        ],
      ),
    );
  }
}
