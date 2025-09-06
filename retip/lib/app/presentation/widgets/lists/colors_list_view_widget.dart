import 'package:flutter/material.dart';

class ColorsListViewWidget extends StatefulWidget {
  const ColorsListViewWidget({super.key});

  @override
  State<ColorsListViewWidget> createState() => _ColorsListViewWidgetState();
}

class _ColorsListViewWidgetState extends State<ColorsListViewWidget> {
  Color _selected = Colors.primaries.first;

  @override
  Widget build(BuildContext context) {
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
          final color = Colors.primaries[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selected = color;
              });
            },
            child: Container(
              color: color,
              height: 40,
              width: 40,
              child: color == _selected
                  ? Center(child: Icon(Icons.check))
                  : null,
            ),
          );
        },
      ),
    );
  }
}
