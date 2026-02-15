import "../gen/assets.gen.dart";

abstract class ContactIconsConfig {
  static final iconsPaths = {
    "facebook": Assets.svg.contactIcons.fb,
    "instagram": Assets.svg.contactIcons.ig,
    "linkedin": Assets.svg.contactIcons.linkedin,
    "mailto:": Assets.svg.contactIcons.mail,
    "youtu": Assets.svg.contactIcons.yt,
    "github": Assets.svg.contactIcons.github,
    "topwr:buildings": Assets.svg.contactIcons.compass,
    "tel": Assets.svg.contactIcons.phone,
    "https://x.com": Assets.svg.contactIcons.x,
    "tiktok": Assets.svg.contactIcons.tiktok,
    "discord": Assets.svg.contactIcons.discord,
    "https://topwr.solvro.pl/buildings/": Assets.svg.contactIcons.compass,
  };
  static final iconsOrder = {
    "https://topwr.solvro.pl/buildings/": 1,
    "tel": 2,
    "mailto:": 3,
    "facebook": 5,
    "instagram": 6,
    "discord": 7,
    "linkedin": 8,
    "github": 9,
    "https://x.com": 10,
    "youtu": 11,
    "tiktok": 12,
  };
  static const defaultIconOrder = 2;
  static final defaultIcon = Assets.svg.contactIcons.web;
}
