import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/audio_repository.dart';

class PlayPauseIcon extends StatefulWidget {
  final bool disabled;
  final double size;

  const PlayPauseIcon({
    this.disabled = false,
    this.size = 32,
    super.key,
  });

  @override
  State<PlayPauseIcon> createState() => _PlayPauseIconState();
}

class _PlayPauseIconState extends State<PlayPauseIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<AudioRepository>();

    return StreamBuilder<bool>(
      stream: repository.playingStream,
      builder: (context, snapshot) {
        final isPlaying = snapshot.data ?? false;

        isPlaying ? controller.forward() : controller.reverse();

        return IconButton.filled(
          onPressed: widget.disabled
              ? null
              : () => isPlaying ? repository.pause() : repository.play(),
          icon: AnimatedIcon(
            size: widget.size,
            icon: AnimatedIcons.play_pause,
            progress: animation,
          ),
          style: Theme.of(context).iconButtonTheme.style?.copyWith(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
        );
      },
    );
  }
}
