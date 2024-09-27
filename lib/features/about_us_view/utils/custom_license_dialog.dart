import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";

Future<void> showCustomLicenseDialog({
  required BuildContext context,
  String? applicationName,
  String? applicationVersion,
  String? applicationLegalese,
  Widget? applicationIcon,
}) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        applicationName ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        applicationVersion ?? "",
                        style: context.textTheme.lightTitle,
                      ),
                    ],
                  ),
                  applicationIcon ?? const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                applicationLegalese ?? "",
                style: context.textTheme.body,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text(context.localize.show_license, style: context.textTheme.bodyOrange.copyWith(fontSize: 16)),
                onPressed: () {
                  showLicensePage(
                    context: context,
                    applicationName: applicationName,
                    applicationIcon: applicationIcon,
                    applicationVersion: applicationVersion,
                    applicationLegalese: applicationLegalese,
                  );
                },
              ),
              TextButton(
                child: Text(context.localize.close, style: context.textTheme.body.copyWith(fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
