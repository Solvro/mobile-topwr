import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/determine_contact_icon.dart";
import "../../../utils/launch_url_util.dart";
import "../../../widgets/zoomable_images.dart";
import "../models/about_us_details.dart";
import "../models/member_data.dart";

class TeamSection extends HookWidget {
  const TeamSection({super.key, required this.multiversionTeam});

  final IList<MultiversionTeam> multiversionTeam;

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(multiversionTeam.last);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AboutUsConfig.defaultPadding),
          child: CupertinoSlidingSegmentedControl<MultiversionTeam>(
            backgroundColor: context.colorTheme.greyLight,
            thumbColor: context.colorTheme.orangePomegranadeLighter,
            groupValue: selectedTab.value,
            onValueChanged: (value) {
              if (value != null) selectedTab.value = value;
            },
            children: {
              for (final version in multiversionTeam)
                version: _SelectTab(version: version, isSelected: selectedTab.value == version),
            },
          ),
        ),
        const SizedBox(height: 20),
        _SingleVersionTeamList(version: selectedTab.value, shimmerTime: 300),
      ],
    );
  }
}

class _SelectTab extends StatelessWidget {
  const _SelectTab({required this.version, required this.isSelected});

  final MultiversionTeam version;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Center(
        child: Semantics(
          label: "${context.localize.version}: ${version.versionName.replaceAll(".", " ")}",
          child: ExcludeSemantics(
            child: Text(
              version.versionName,
              style:
                  isSelected
                      ? context.textTheme.boldBody.copyWith(color: context.colorTheme.whiteSoap)
                      : context.textTheme.boldBody,
            ),
          ),
        ),
      ),
    );
  }
}

class _SingleVersionTeamList extends StatefulWidget {
  const _SingleVersionTeamList({required this.version, required this.shimmerTime});

  final MultiversionTeam version;
  final int shimmerTime;

  @override
  _SingleVersionTeamListState createState() => _SingleVersionTeamListState();
}

class _SingleVersionTeamListState extends State<_SingleVersionTeamList> {
  bool _showLoader = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startLoaderTimer();
  }

  @override
  void didUpdateWidget(covariant _SingleVersionTeamList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.version != widget.version) {
      setState(() {
        _showLoader = true;
      });
      _startLoaderTimer();
    }
  }

  void _startLoaderTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: widget.shimmerTime), () {
      if (mounted) {
        setState(() {
          _showLoader = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final version = widget.version;

    final double expectedHeight =
        version.members.isEmpty ? 100.0 : version.members.length * WideTileCardConfig.imageSize;

    final content =
        version.members.isEmpty
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Icon(Icons.escalator_warning), Text(context.localize.emptySection)],
            )
            : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: version.members.length,
              prototypeItem: _TeamMemberCard(member: version.members.first),
              itemBuilder: (BuildContext ctx, int index) {
                return _TeamMemberCard(member: version.members[index]);
              },
            );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AboutUsConfig.defaultPadding),
      child: SizedBox(
        height: expectedHeight,
        child: Stack(
          children: [
            content,
            AnimatedOpacity(
              opacity: _showLoader ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1),
              child: ColoredBox(
                color: context.colorTheme.whiteSoap,
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(padding: EdgeInsets.only(top: 16), child: CircularProgressIndicator()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  const _TeamMemberCard({required this.member});

  final MemberData member;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WideTileCardConfig.imageSize,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: context.colorTheme.greyLight,
            borderRadius: BorderRadius.circular(AboutUsConfig.borderRadius),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExcludeSemantics(
                child: SizedBox.square(
                  dimension: AboutUsConfig.photoSize,
                  child: ZoomableOptimizedDirectusImage(member.directusImageUrl),
                ),
              ),
              const SizedBox(width: 14),
              _Description(name: member.name ?? "", subtitle: member.subtitle ?? "", links: member.links),
            ],
          ),
        ),
      ),
    );
  }
}

class _Icon extends ConsumerWidget {
  const _Icon({required this.icon, required this.launchUrl});

  final String launchUrl;
  final String icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 11),
      child: GestureDetector(
        onTap: () async {
          await ref.launch(launchUrl);
        },
        child: SizedBox.square(dimension: 22, child: SvgPicture.asset(icon)),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.name, required this.subtitle, required this.links});

  final String name;
  final String subtitle;
  final IList<ContactIconsModel> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name, style: context.aboutUsTheme.headlineSmaller),
        const SizedBox(height: 4),
        Text(subtitle, style: context.aboutUsTheme.bodySmaller),
        const SizedBox(height: 8),
        Row(
          children: [
            for (final icon in links)
              Semantics(
                label: "${context.localize.button_leading_to}: ${icon.url?.substring(7)}",
                child: _Icon(launchUrl: icon.url ?? "", icon: icon.icon),
              ),
          ],
        ),
      ],
    );
  }
}
