import "../gen/assets.gen.dart";

abstract class IconsConfig {
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
  static final defaultIcon = Assets.contactIcons.web;
}
