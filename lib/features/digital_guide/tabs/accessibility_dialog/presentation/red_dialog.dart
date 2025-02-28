import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";

// pure UI, no logic, just a nice dialog with a title, subtitle and a child
class RedDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const RedDialog({super.key, required this.title, required this.child, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colorTheme.whiteSoap,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            top: BorderSide(color: context.colorTheme.orangePomegranade),
            bottom: BorderSide(color: context.colorTheme.orangePomegranade, width: 5),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(64), offset: const Offset(0, 4), blurRadius: 4)],
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 332),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _DialogHeader(title: title),
              Flexible(child: SingleChildScrollView(child: _DialogContent(subtitle: subtitle, child: child))),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({required this.subtitle, required this.child});

  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            subtitle,
            style: context.aboutUsTheme.body.copyWith(height: 1.4, color: context.colorTheme.greyPigeon),
          ),
        ),
        const SizedBox(height: 6),
        child,
        const _DialogFooter(),
      ],
    );
  }
}

class _DialogFooter extends StatelessWidget {
  const _DialogFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DialogsConfig.padding,
      child: ElevatedButton(
        onPressed: () {
          // we're saving the changes in real time anyway
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorTheme.orangePomegranadeLighter,
          elevation: 2,
          padding: FilterConfig.buttonPadding,
          shape: RoundedRectangleBorder(borderRadius: FilterConfig.radius),
        ),
        child: Center(child: Text(context.localize.apply, style: context.textTheme.titleWhite)),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20).copyWith(bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: context.textTheme.headline.copyWith(height: 1.4))),
          IconButton(
            icon: const Icon(Icons.close),
            color: context.colorTheme.greyPigeon,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
