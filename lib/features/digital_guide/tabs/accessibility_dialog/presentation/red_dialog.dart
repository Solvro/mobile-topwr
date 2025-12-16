import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";

// pure UI, no logic, just a nice dialog with a title, subtitle and a child
class RedDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final bool showApplyButton;
  final bool centerTitle;
  final String? applyButtonText;
  final bool showCloseButton;
  final VoidCallback? onApplyButtonPressed;
  const RedDialog({
    super.key,
    required this.title,
    required this.child,
    required this.subtitle,
    this.showApplyButton = true,
    this.centerTitle = false,
    this.applyButtonText,
    this.showCloseButton = true,
    this.onApplyButtonPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            top: BorderSide(color: context.colorScheme.primary),
            bottom: BorderSide(color: context.colorScheme.primary, width: 5),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(64), offset: const Offset(0, 4), blurRadius: 4)],
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 332),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _DialogHeader(title: title, centerTitle: centerTitle, showCloseButton: showCloseButton),
              Flexible(
                child: SingleChildScrollView(
                  child: _DialogContent(
                    subtitle: subtitle,
                    applyButtonText: applyButtonText,
                    showApplyButton: showApplyButton,
                    onApplyButtonPressed: onApplyButtonPressed,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    required this.subtitle,
    required this.child,
    required this.showApplyButton,
    this.applyButtonText,
    this.onApplyButtonPressed,
  });

  final String? subtitle;
  final Widget child;
  final bool showApplyButton;
  final String? applyButtonText;
  final VoidCallback? onApplyButtonPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (subtitle != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              subtitle!,
              style: context.textTheme.labelLarge!.copyWith(height: 1.4, color: context.colorScheme.tertiary),
            ),
          ),
          const SizedBox(height: 6),
        ],
        child,
        if (showApplyButton)
          _DialogFooter(applyButtonText: applyButtonText, onApplyButtonPressed: onApplyButtonPressed),
      ],
    );
  }
}

class _DialogFooter extends StatelessWidget {
  const _DialogFooter({required this.applyButtonText, required this.onApplyButtonPressed});

  final String? applyButtonText;
  final VoidCallback? onApplyButtonPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DialogsConfig.padding,
      child: ElevatedButton(
        onPressed: () {
          // we're saving the changes in real time anyway
          onApplyButtonPressed?.call();
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.primaryContainer,
          elevation: 2,
          padding: FilterConfig.buttonPadding,
          shape: RoundedRectangleBorder(borderRadius: FilterConfig.radius),
        ),
        child: Center(
          child: Text(
            applyButtonText ?? context.localize.apply,
            style: context.textTheme.titleLarge?.copyWith(color: context.colorScheme.surface),
          ),
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.title, required this.centerTitle, required this.showCloseButton});

  final String title;
  final bool centerTitle;
  final bool showCloseButton;
  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 0.9);
    final baseStyle = context.textTheme.headlineMedium?.copyWith(height: 1.4);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: baseStyle?.copyWith(fontSize: scaler.scale(baseStyle.fontSize ?? 20)),
              textAlign: centerTitle ? TextAlign.center : TextAlign.left,
            ),
          ),
          if (!centerTitle)
            // a workaround, but the actual button provides some padding too and I don't have a power to play around with paddings anymore
            Transform.translate(
              offset: const Offset(10, 0),
              child: Opacity(
                opacity: showCloseButton ? 1 : 0,
                child: IgnorePointer(
                  ignoring: !showCloseButton,
                  child: MergeSemantics(
                    child: IconButton(
                      icon: Semantics(label: context.localize.close, child: const Icon(Icons.close)),
                      color: context.colorScheme.tertiary,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
