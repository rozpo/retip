import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/cubits/theme/theme_cubit.dart';

class ColorsListViewWidget extends StatelessWidget {
  const ColorsListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) {
              return SizedBox(width: 8);
            },
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: Colors.primaries.length,
            itemBuilder: (context, index) {
              final color = Color(Colors.primaries[index].toARGB32());

              return GestureDetector(
                onTap: () {
                  context.read<ThemeCubit>().setSeedColor(color);
                },
                child: Container(
                  color: color,
                  height: 40,
                  width: 40,
                  child: color == state.seedColor
                      ? Center(child: Icon(Icons.check))
                      : null,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
