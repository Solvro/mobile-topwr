import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../services/haptics/app_haptics.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/launch_url_util.dart";
import "../../navigator/navigation_stack.dart";
import "../data/repository/remote_config_repository.dart";

class KillSwitchOverlay extends HookConsumerWidget {
  const KillSwitchOverlay({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final killSwitchEnabled = ref.watch(remoteConfigRepositoryProvider).value?.killswitchOfDoomAndDespair ?? false;
    final route = ref.watch(currentRouteProvider);
    final dialogWasShown = useRef(false);
    final bannerCollapsed = useState(false);
    void toggleBanner() => bannerCollapsed.value = !bannerCollapsed.value;

    useEffect(() {
      if (!killSwitchEnabled) bannerCollapsed.value = false;
      return null;
    }, [killSwitchEnabled]);

    useEffect(() {
      if (!killSwitchEnabled) {
        dialogWasShown.value = false;
        return null;
      }

      final navigator = route?.navigator;
      if (navigator == null || dialogWasShown.value) return null;
      dialogWasShown.value = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!navigator.mounted) return;
        unawaited(
          showDialog<void>(
            context: navigator.context,
            barrierDismissible: false,
            builder: (_) => const _KillSwitchDialog(),
          ),
        );
      });
      return null;
    }, [killSwitchEnabled, route]);

    final isScienceClubRoute = route?.settings.name?.startsWith("ScienceClub") ?? false;
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        if (killSwitchEnabled && !isScienceClubRoute)
          _KillSwitchBanner(collapsed: bannerCollapsed.value, onPressed: toggleBanner),
      ],
    );
  }
}

class _KillSwitchBanner extends StatelessWidget {
  const _KillSwitchBanner({required this.collapsed, required this.onPressed});

  final bool collapsed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: collapsed ? null : 16,
      right: 16,
      bottom: 88,
      child: SafeArea(
        top: false,
        child: Semantics(
          liveRegion: true,
          container: true,
          button: true,
          label: context.localize.kill_switch_banner,
          child: Material(
            color: context.colorScheme.errorContainer,
            elevation: 12,
            borderRadius: BorderRadius.circular(collapsed ? 28 : 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(collapsed ? 28 : 16),
              onTap: AppHaptics.wrapperLight(onPressed),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: collapsed
                    ? Icon(
                        Icons.warning_amber_rounded,
                        color: context.colorScheme.onErrorContainer,
                        semanticLabel: context.localize.kill_switch_banner,
                      )
                    : Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: context.colorScheme.onErrorContainer,
                            semanticLabel: context.localize.kill_switch_banner,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              context.localize.kill_switch_banner,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _KillSwitchDialog extends ConsumerWidget {
  const _KillSwitchDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        icon: Icon(
          Icons.warning_amber_rounded,
          color: context.colorScheme.error,
          semanticLabel: context.localize.kill_switch_dialog_title,
        ),
        title: Text(context.localize.kill_switch_dialog_title),
        content: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "${context.localize.kill_switch_dialog_message} "),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Semantics(
                  link: true,
                  label: context.localize.report_change_email,
                  child: InkWell(
                    onTap: AppHaptics.wrapperLight(() => ref.launch("mailto:${context.localize.report_change_email}")),
                    child: Text(
                      context.localize.report_change_email,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: AppHaptics.wrapperLight(() => ref.launch("mailto:${context.localize.report_change_email}")),
            icon: Icon(Icons.email_outlined, semanticLabel: context.localize.kill_switch_contact),
            label: Text(context.localize.kill_switch_contact),
          ),
          FilledButton(
            onPressed: AppHaptics.wrapperLight(() => Navigator.of(context).pop()),
            child: Text(context.localize.kill_switch_dismiss),
          ),
        ],
      ),
    );
  }
}
