import 'package:flutter/material.dart';

class PlayPauseButtonWidget extends StatefulWidget {
  final Stream<bool> stream;
  final VoidCallback? onPressed;

  const PlayPauseButtonWidget({
    required this.stream,
    this.onPressed,
    super.key,
  });

  @override
  State<PlayPauseButtonWidget> createState() => _PlayPauseButtonWidgetState();
}

class _PlayPauseButtonWidgetState extends State<PlayPauseButtonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> progress;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    progress = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.requireData) {
          controller.reverse();
        } else {
          controller.forward();
        }

        return IconButton.filled(
          style: Theme.of(context).iconButtonTheme.style,
          onPressed: widget.onPressed,
          icon: AnimatedIcon(
            color: Theme.of(context).colorScheme.onPrimary,
            icon: AnimatedIcons.play_pause,
            progress: progress,
          ),
        );
      },
    );
  }
}
