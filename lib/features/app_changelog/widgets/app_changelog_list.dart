import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../data/models/changelog.dart";

class AppChangelogList extends StatelessWidget {
  const AppChangelogList({super.key, required this.changelog});

  final Changelog changelog;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => _ListItem(
          tag: changelog.changes[index].changeType.name.toUpperCase(),
          description: changelog.changes[index].name,
        ),
        itemCount: changelog.changes.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 14),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({required this.tag, required this.description});

  final String tag;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * 0.2,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
            color: context.colorTheme.whiteSoap,
            border: Border.all(color: context.colorTheme.orangePomegranade, width: 1.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(tag, style: context.textTheme.smallOrange),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(description, style: context.textTheme.body, overflow: TextOverflow.clip),
        ),
      ],
    );
  }
}
