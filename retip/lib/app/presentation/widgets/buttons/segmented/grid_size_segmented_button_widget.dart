import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

import '../../../../domain/enums/grid_size_enum.dart';

class GridSizeSegmentedButtonWidget extends StatefulWidget {
  const GridSizeSegmentedButtonWidget({super.key});

  @override
  State<GridSizeSegmentedButtonWidget> createState() =>
      _GridSizeSegmentedButtonWidgetState();
}

class _GridSizeSegmentedButtonWidgetState
    extends State<GridSizeSegmentedButtonWidget> {
  var _mode = GridSizeEnum.medium;

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return SegmentedButton<GridSizeEnum>(
      expandedInsets: EdgeInsets.symmetric(horizontal: 16),
      onSelectionChanged: (newSelection) {
        setState(() => _mode = newSelection.first);
      },
      segments: [
        ButtonSegment<GridSizeEnum>(
          value: GridSizeEnum.small,
          icon: Icon(Icons.grid_goldenratio),
          label: Text(l10n.small),
        ),
        ButtonSegment<GridSizeEnum>(
          value: GridSizeEnum.medium,
          icon: Icon(Icons.grid_3x3),
          label: Text(l10n.medium),
        ),
        ButtonSegment<GridSizeEnum>(
          value: GridSizeEnum.large,
          icon: Icon(Icons.grid_4x4),
          label: Text(l10n.large),
        ),
      ],
      selected: {_mode},
    );
  }
}
