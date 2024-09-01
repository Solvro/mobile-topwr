import "../gen/assets.gen.dart";

abstract class ContactIconsConfig {
  static final iconsPaths = {
    "facebook": Assets.contactIcons.fb,
    "instagram": Assets.contactIcons.ig,
    "linkedin": Assets.contactIcons.linkedin,
    "mailto:": Assets.contactIcons.mail,
    "youtu": Assets.contactIcons.yt,
    "github": Assets.contactIcons.github,
    "topwr:buildings": Assets.contactIcons.compass,
    "tel": Assets.contactIcons.phone,
    "https://x.com": Assets.contactIcons.x,
    "tiktok": Assets.contactIcons.tiktok,
    "discord": Assets.contactIcons.discord,
  };
  static final iconsOrder = {
    "maps": 1,
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
  static final defaultIcon = Assets.contactIcons.web;
}
