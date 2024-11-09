import "package:flutter/cupertino.dart";
import "sks_menu_tiles.dart";

class SksMenuSection extends StatelessWidget {
  SksMenuSection({super.key});

  final Map<String, List<Dish>> categories = {
    "Surówki": [
      Dish("5.00", "150g", "Surówka z kapusty"),
      Dish("4.50", "120g", "Surówka z marchewki"),
      Dish("5.50", "130g", "Surówka z buraków"),
    ],
    "Zupy": [
      Dish("8.00", "250ml", "Dyniowa"),
      Dish("9.00", "250ml", "Grzybowa"),
      Dish("7.50", "250ml", "Pomidorowa"),
    ],
    "Dania jarskie": [
      Dish("12.00", "200g", "Krokiety z kapustą i grzybami"),
      Dish("10.00", "180g", "Naleśniki"),
    ],
    "Dania mięsne": [
      Dish("15.00", "200g", "Kotlet schabowy"),
      Dish("14.00", "180g", "Kotlet mielony"),
      Dish("16.00", "220g", "Karkówka"),
    ],
    "Dodatki": [
      Dish("3.00", "200g", "Ziemniaki"),
      Dish("3.50", "200g", "Ryż"),
      Dish("4.00", "200g", "Kasza gryczana"),
    ],
    "Kompoty i napoje": [
      Dish("2.50", "200ml", "Napój z soku jabłkowego"),
      Dish("3.00", "200ml", "Kompot"),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categories.entries.map((entry) {
        return SksMenuTile(
          title: entry.key,
          dishes: entry.value,
        );
      }).toList(),
    );
  }
}

class Dish {
  String price;
  String size;
  String name;

  Dish(this.price, this.size, this.name);
}
