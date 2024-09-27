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
  static final iconsOrderAtSciClubs = {
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
  static final iconsOrderAtAboutUs = {
    "github": 1,
    "linkedin": 2,
    "facebook": 4,
    "mailto:": 5,
    "instagram": 6,
    "https://x.com": 7,
    "discord": 8,
    "youtu": 9,
    "tiktok": 10,
    "maps": 11,
    "tel": 12,
  };
  static const defaultIconOrderAtSciClubs = 2;
  static const defaultIconOrderAtAboutUs = 3;
  static final defaultIcon = Assets.svg.contactIcons.web;
}
