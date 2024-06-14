import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'widgets/about_us/about_us_tab.dart';

class GuideViewTemplate extends StatelessWidget {
  const GuideViewTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('O nas'),
        backgroundColor: context.colorTheme.greyLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsTab(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.colorTheme.greyLight,
                ),
                child: Text(
                  'O nas',
                  style: TextStyle(
                      fontSize: 24,
                      color: context.colorTheme.orangePomegranade),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
