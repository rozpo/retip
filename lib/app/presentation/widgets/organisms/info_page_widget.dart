import 'package:flutter/material.dart';

class InfoPageWidget extends StatelessWidget {
  final String description;
  final IconData iconData;
  final String title;
  final bool isQuote;

  const InfoPageWidget({
    required this.description,
    required this.iconData,
    this.isQuote = false,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
              title,
            ),
            const SizedBox(height: 16),
            Center(
              child: Icon(
                iconData,
                size: size.shortestSide * 0.5,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontStyle: isQuote ? FontStyle.italic : FontStyle.normal,
                  ),
              textAlign: TextAlign.center,
              isQuote ? '"$description"' : description,
            ),
          ],
        ),
      ),
    );
  }
}
