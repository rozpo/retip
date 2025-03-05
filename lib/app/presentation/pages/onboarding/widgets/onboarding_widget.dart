import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  final VoidCallback onNext;
  final String description;
  final IconData iconData;
  final String buttonText;
  final String subtitle;
  final String title;

  const OnboardingWidget({
    required this.description,
    required this.buttonText,
    required this.iconData,
    required this.subtitle,
    required this.onNext,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
              title,
            ),
            Center(
                child: Icon(
              iconData,
              size: size.shortestSide * 0.5,
              color: Theme.of(context).colorScheme.tertiary,
            )),
            Text(
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
              description,
            ),
          ],
        ),
      ),
    );
  }
}
