import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

enum SectionSize {
  large(3),
  medium(4),
  small(5);

  final int size;

  const SectionSize(this.size);
}

class SectionGrid extends StatelessWidget {
  final SectionSize size;
  final String title;
  final int count;
  final Widget Function(BuildContext context, int index) builder;

  const SectionGrid({
    required this.title,
    required this.builder,
    this.size = SectionSize.medium,
    this.count = 10,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size.width / size.size;
    // final contentDimension = dimension - Sizer.x4 - 4;
    return SizedBox(
      height: dimension,
      child: ListView.separated(
        padding: const EdgeInsets.all(Sizer.x1),
        separatorBuilder: (context, index) {
          return const SizedBox.square(
            dimension: Sizer.x1,
          );
        },
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (context, index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox.fromSize(
                size: constraints.smallest,
              );
            },
          );
        },
        // itemBuilder: (context, index) {

        //   // return Container(
        //   //   height: dimension,
        //   //   width: dimension,
        //   //   // color: Theme.of(context).colorScheme.surfaceContainer,
        //   //   color: Colors.red,
        //   // );
        // },
      ),
    );
  }
}
