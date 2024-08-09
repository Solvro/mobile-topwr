import "../gen/assets.gen.dart";

abstract class ContactIconsConfig {
  static final iconsPaths = {
    "facebook": Assets.contactIcons.fb,
    "instagram": Assets.contactIcons.ig,
    "linkedin": Assets.contactIcons.linkedin,
    "mailto:": Assets.contactIcons.mail,
    "youtu": Assets.contactIcons.yt,
    "github": Assets.contactIcons.github,
    "maps": Assets.contactIcons.compass,
    "tel": Assets.contactIcons.phone,
  };
  static final iconsOrder = {
    "maps": 1,
    "tel": 3,
    "mailto:": 4,
    "facebook": 5,
    "instagram": 6,
    "linkedin": 7,
    "github": 8,
    "youtu": 9,
  };
  static const defaultIconOrder = 2;
  static final defaultIcon = Assets.contactIcons.web;
}
