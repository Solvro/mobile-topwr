import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";
import "../data/feature_codes_repository.dart";

class FeatureCodesDialog extends HookConsumerWidget {
  const FeatureCodesDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(context: context, builder: (context) => const FeatureCodesDialog());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codes = ref.watch(featureCodesRepositoryProvider);
    final controller = useTextEditingController();
    final canAdd = useState(false);
    final focusNode = useFocusNode();

    final onAdd = useCallback(() async {
      final value = controller.text.trim();
      if (value.isEmpty) return;
      await ref.read(featureCodesRepositoryProvider.notifier).addCode(value);
      controller.clear();
      canAdd.value = false;
      focusNode.requestFocus();
    }, [controller, ref, canAdd, focusNode]);

    return Semantics(
      container: true,
      label: context.localize.dialog_semantics_label,
      child: Focus(
        autofocus: true,
        child: RedDialog(
          title: context.localize.feature_codes_title,
          subtitle: context.localize.feature_codes_subtitle,
          applyButtonText: context.localize.ok,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _InputRow(controller: controller, focusNode: focusNode, canAdd: canAdd, onAdd: onAdd),
                const SizedBox(height: 12),
                _CodesList(
                  codes: codes.toList(),
                  onRemove: (code) async {
                    await ref.read(featureCodesRepositoryProvider.notifier).removeCode(code);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputRow extends HookWidget {
  const _InputRow({required this.controller, required this.focusNode, required this.canAdd, required this.onAdd});

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueNotifier<bool> canAdd;
  final Future<void> Function() onAdd;

  @override
  Widget build(BuildContext context) {
    final onChanged = useCallback((String value) {
      canAdd.value = value.trim().isNotEmpty;
    }, [canAdd]);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: TextInputAction.done,
            onChanged: onChanged,
            onSubmitted: (_) async {
              await onAdd();
            },
            decoration: InputDecoration(
              hintText: context.localize.feature_codes_input_hint,
              filled: true,
              fillColor: context.colorScheme.surfaceTint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: canAdd.value
              ? () async {
                  unawaited(HapticFeedback.selectionClick());
                  await onAdd();
                }
              : null,
          icon: const Icon(Icons.add, semanticLabel: ""),
          color: context.colorScheme.primary,
          tooltip: context.localize.feature_codes_add_button,
        ),
      ],
    );
  }
}

class _CodesList extends StatelessWidget {
  const _CodesList({required this.codes, required this.onRemove});

  final List<String> codes;
  final Future<void> Function(String code) onRemove;

  @override
  Widget build(BuildContext context) {
    if (codes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          context.localize.feature_codes_empty,
          style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.tertiary),
        ),
      );
    }

    final sortedCodes = codes.toList()..sort();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final code = sortedCodes[index];
        return Material(
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.surfaceTint,
          child: ListTile(
            dense: true,
            title: Text(code, style: context.textTheme.bodyLarge),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, semanticLabel: ""),
              tooltip: context.localize.feature_codes_remove_button,
              onPressed: () async {
                unawaited(HapticFeedback.selectionClick());
                await onRemove(code);
              },
            ),
          ),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemCount: sortedCodes.length,
    );
  }
}
