import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/router/retip_routes.dart';
import '../../../domain/repositories/config_repository.dart';
import 'widgets/onboarding_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  final pagesCount = 3;
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              final configRepository = context.read<ConfigRepository>();
              await configRepository.setOnboardingStatus(false);

              if (context.mounted == false) return;
              context.go(RetipRoutes.home);
            },
            child: Text('Skip'.toUpperCase()),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (value) => setState(() => currentPage = value),
              controller: controller,
              children: [
                OnboardingWidget(
                  iconData: Icons.headphones,
                  title: 'Welcome to Retip!',
                  subtitle: 'Music player',
                  description:
                      'Your music, your way. Enjoy your local music library, offline and uninterrupted.',
                  buttonText: 'Get started',
                  onNext: () => controller.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                  ),
                ),
                OnboardingWidget(
                  iconData: Icons.wifi_off,
                  title: 'How it works?',
                  subtitle: 'Music player',
                  description:
                      'Retip scans your device for music files, letting you browse and play your collection instantly.',
                  buttonText: 'Next',
                  onNext: () => controller.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                  ),
                ),
                OnboardingWidget(
                  iconData: Icons.album,
                  title: 'Our motton',
                  subtitle: 'Music player',
                  description:
                      "If you think that in the era of streaming, the art of offline listening to music has not disappeared. It's a sure sign that you need a RETIP!",
                  buttonText: "Let's go",
                  onNext: () async {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: pagesCount,
                  effect: WormEffect(
                    activeDotColor: Theme.of(context).colorScheme.primary,
                    dotColor: Theme.of(context).colorScheme.surfaceBright,
                  ),
                  onDotClicked: (index) {
                    controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                FilledButton(
                  onPressed: () async {
                    if (currentPage == pagesCount - 1) {
                      final configRepository = context.read<ConfigRepository>();
                      await configRepository.setOnboardingStatus(false);

                      if (context.mounted == false) return;
                      context.go(RetipRoutes.home);
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    (currentPage != pagesCount - 1 ? 'Next' : 'Finish')
                        .toUpperCase(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
