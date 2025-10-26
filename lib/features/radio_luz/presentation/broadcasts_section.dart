import "package:carousel_slider_plus/carousel_slider_plus.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../data/repository/schedule_repository.dart";

class BroadcastsSection extends HookConsumerWidget {
  const BroadcastsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(CarouselSliderController.new);
    final broadcastsProvider = ref.watch(scheduleRepositoryProvider);

    return switch (broadcastsProvider) {
      AsyncData(:final value) => SizedBox(
        height: 250,
        child: CarouselSlider(
          controller: controller,
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.6,
            enlargeFactor: 0.2,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            initialPage: value?.indexWhere((broadcast) => broadcast.isNow) ?? 0,
          ),
          items: List.generate(
            value == null ? 0 : value.length,
            (index) => _BroadcastTile(
              title: value![index].title,
              imageUrl: value[index].thumbnail,
              nowPlaying: value[index].isNow,
            ),
          ),
        ),
      ),
      // TODO(tt): add shimmer effect
      AsyncLoading() => Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CircularProgressIndicator(color: context.colorTheme.orangePomegranade),
        ),
      ),
      _ => Column(children: [Text(context.localize.generic_error_message)]),
    };
  }
}

class _BroadcastTile extends StatelessWidget {
  const _BroadcastTile({required this.title, required this.imageUrl, this.nowPlaying = false});

  final String title;
  final String imageUrl;
  final bool nowPlaying;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(imageUrl, fit: BoxFit.cover),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: context.colorTheme.orangePomegranadeLighter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (nowPlaying) ...[
                    Text(
                      context.localize.now_playing.toUpperCase(),
                      style: context.textTheme.title.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(title, style: context.textTheme.title.copyWith(color: Colors.white)),
                  const SizedBox(height: 4),
                  const _ShowMoreWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowMoreWidget extends StatelessWidget {
  const _ShowMoreWidget();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.localize.show_more, style: context.textTheme.title.copyWith(color: Colors.white)),
            const Expanded(child: Divider(color: Colors.white, thickness: 1, height: 1)),
          ],
        ),
        const Positioned(bottom: 0, right: 0, child: Icon(Icons.arrow_right, color: Colors.white, size: 18)),
      ],
    );
  }
}
