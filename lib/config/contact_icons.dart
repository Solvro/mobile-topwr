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
  };
  static final iconsOrder = {
    "maps": 1,
    "tel": 2,
    "linkedin": 3,
    "facebook": 4,
    "instagram": 5,
    "discord": 6,
    "mailto:": 7,
    "github": 8,
    "https://x.com": 9,
    "youtu": 10,
    "tiktok": 11,
  };
  static const defaultIconOrder = 2;
  static final defaultIcon = Assets.svg.contactIcons.web;
}
