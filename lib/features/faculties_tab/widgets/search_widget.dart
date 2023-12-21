import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: '${context.localize!.search}...',
          hintStyle: TextStyle(
            color: context.colorTheme.blackMirage,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
            gapPadding: 0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
            gapPadding: 0,
          ),
          icon: Icon(
            Icons.search_outlined,
            size: 14,
            color: context.colorTheme.blackMirage,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
