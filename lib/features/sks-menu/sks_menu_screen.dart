import "dart:core";

import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:separate/separate.dart";

import "../../theme/app_theme.dart";
import "../../utils/determine_contact_icon.dart";
import "../../widgets/detail_views/contact_section.dart";
import "../../widgets/detail_views/detail_view_app_bar.dart";
import "../../widgets/my_cached_image.dart";
import "../../widgets/my_expansion_tile.dart";

@RoutePage()
class SksMenuView extends StatelessWidget {
  const SksMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailViewAppBar(context, title: ""),
      body: ListView(
        children: [
          const SizedBox(
            height: 300,
            child: MyCachedImage(
                "https://admin.topwr.solvro.pl/assets/5b188776-211f-4fcd-9440-eac964502aec?cache-buster=2024-09-04T12:59:35"),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MyExpansionTile(
              title: "Kontakt",
              children: [
                ContactSection(
                  list: IList([
                    ContactIconsModel(
                      text: "dss@pwr.edu.pl",
                      url: "mailto:example@example.com",
                    ),
                    ContactIconsModel(
                      text: "+48 71 340 7530 (Kawiarnia SKS)",
                      url: "tel:",
                    ),
                    ContactIconsModel(
                      text: "+48 71 320 3812 (Gmach Główny)",
                      url: "tel:",
                    ),
                    ContactIconsModel(
                      text: "+48 71 340 7530 (Rezerwacje SKS)",
                      url: "tel:",
                    ),
                  ]),
                  title: "Kontakt",
                ),
              ],
            ),
          ),
         const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: MyExpansionTile(title: "Wykres aktywności", children: []),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: MenuSection(),
          ),
        ],
      ),
    );
  }
}

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Menu 31.10.2024",
          style: context.textTheme.headlineOrange,
          textAlign: TextAlign.center,
        ),
        SksMenuTile(
          title: "Surówki",
          dishes: [
            Dish("4.00", "100g", "Marchew z groszkiem i sezamem"),
            Dish("4.00", "100g", "Surówka z kisz. ogórków i jabłek"),
          ],
        ),
        SksMenuTile(
          title: "Zupy",
          dishes: [
            Dish("6.50", "300ml", "Krem z pieczonych pomidorów z ziołami"),
            Dish("6.50", "300ml", "Zupa ogórkowa zab. z ziemniakami"),
          ],
        ),
        SksMenuTile(
          title: "Dania jarskie",
          dishes: [
            Dish("15.00", "250g/50g", "Kopytka domowe z s.grzybowym"),
            Dish("15.00", "250g", "Pampuchy drożdż. z sosem grzybowym"),
          ],
        ),
        SksMenuTile(
          title: "Dania mięsne",
          dishes: [
            Dish("15.00", "120g/30g", "Stek z karczku po cygańsku"),
            Dish("15.00", "120g", "Sznycel z indyka panierowany"),
          ],
        ),
        SksMenuTile(
          title: "Dodatki",
          dishes: [
            Dish("4.50", "250g", "Ziemniaki z koperkiem"),
          ],
        ),
        SksMenuTile(
          title: "Kompoty i napoje",
          dishes: [
            Dish("2.50", "200ml", "Napój z soku jabłkowego"),
          ],
        ),
      ],
    );
  }
}

class SksMenuTile extends StatelessWidget {
  const SksMenuTile({super.key, required this.title, required this.dishes});

  final String title;
  final List<Dish> dishes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: MyExpansionTile(
        backgroundColor: context.colorTheme.whiteSoap,
        initiallyExpanded: true,
        title: title,
        children: dishes
            .map<Widget>((dish) => SksMenuDishDetailsTile(dish: dish))
            .separate((i, e0, e1) => const SizedBox(height: 12))
            .toList(),
      ),
    );
  }
}

class SksMenuDishDetailsTile extends StatelessWidget {
  const SksMenuDishDetailsTile({super.key, required this.dish});

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorTheme.whiteSoap,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: context.colorTheme.orangePomegranade.withAlpha(50)),
      ),
      child: ListTile(
        title: Text(
          dish.name,
          style: context.textTheme.lightTitle,
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Text(
            "${dish.price} zł | ${dish.size}",
            style: context.textTheme.title,
          ),
        ),
      ),
    );
  }
}

class Dish {
  String price;
  String size;
  String name;

  Dish(this.price, this.size, this.name);
}
