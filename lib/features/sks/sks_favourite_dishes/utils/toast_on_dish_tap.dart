import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:fluttertoast/fluttertoast.dart";

import "../../../../theme/colors.dart";
import "../../../../utils/context_extensions.dart";
import "../data/repository/sks_favourite_dishes_repository.dart";

Future<void> toastOnDishTap({
  required String dishId,
  required WidgetRef ref,
  required BuildContext context,
  required bool subscribe,
}) async {
  final success = await ref
      .read(sksFavouriteDishesRepositoryProvider.notifier)
      .toggleDishSubscription(dishId, subscribe: subscribe);
  if (!success && context.mounted) {
    await Fluttertoast.showToast(
      msg: context.localize.sks_favourite_dishes_couldnt_update,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: ColorsConsts.orangePomegranade,
      textColor: ColorsConsts.greyLight,
    );
  }
}
