import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../gen/assets.gen.dart";

class LottieLoading extends StatefulWidget {
  const LottieLoading({
    super.key,
  });

  @override
  _LottieLoadingState createState() => _LottieLoadingState();
}

class _LottieLoadingState extends State<LottieLoading> {
  final bool _showOldMenu = false;

  void _gotoOldMenu() {
    //Navigator.push(
    //context,
    //MaterialPageRoute(builder: (context) => const _SksMenuView()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                Assets.animations.closed,
                repeat: false,
              ),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: MaterialButton(
                elevation: 1,
                padding: const EdgeInsets.all(8),
                onPressed: _gotoOldMenu,
                color: context.colorTheme.greyLight,
                textColor: context.colorTheme.blackMirage,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _showOldMenu
                      ? context.localize.close
                      : context.localize.sks_old_menu,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
