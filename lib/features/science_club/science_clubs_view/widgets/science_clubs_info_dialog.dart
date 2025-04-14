import 'package:flutter/material.dart';

class ScienceClubInfoDialog extends StatelessWidget {
  const ScienceClubInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.mail_outline,
              size: 48,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            Text(
              "Skontaktuj się z nami",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              "Jeżeli twoje koło nie znajduje się na liście, skontaktuj się z nami poprzez maila.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}
