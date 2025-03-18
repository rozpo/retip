import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/l10n/retip_l10n.dart';
import '../../../core/router/retip_routes.dart';
import '../cubits/onboarding/onboarding_cubit.dart';
import '../widgets/organisms/info_page_widget.dart';

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
    final cubit = context.read<OnboardingCubit>();
    final l10n = context.read<RetipL10n>().of(context);

    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingFinished) {
          context.go(RetipRoutes.home);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () => cubit.finishOnboarding(),
              child: Text(l10n.skip.toUpperCase()),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (value) => setState(() => currentPage = value),
                  controller: controller,
                  children: [
                    InfoPageWidget(
                      description: l10n.welcomeToRetipDescription,
                      title: l10n.welcomeToRetip,
                      iconData: Icons.headphones,
                    ),
                    InfoPageWidget(
                      iconData: Icons.wifi_off,
                      title: l10n.howItWorks,
                      description: l10n.howItWorksDescription,
                    ),
                    InfoPageWidget(
                      isQuote: true,
                      iconData: Icons.album,
                      title: l10n.ourMottto,
                      description: l10n.ourMottoDescription,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: pagesCount,
                      effect: WormEffect(
                        activeDotColor: Theme.of(context).colorScheme.primary,
                        dotColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
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
                      onPressed: () {
                        if (currentPage == pagesCount - 1) {
                          cubit.finishOnboarding();
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        (currentPage != pagesCount - 1
                                ? l10n.next
                                : l10n.finish)
                            .toUpperCase(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
