import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/atoms/rp_icon_button.dart';
import '../../../../widgets/molecules/rp_snackbar.dart';
import '../../../../../../core/l10n/retip_l10n.dart';

import '../../bloc/tracks_bloc.dart';

class SortTracksButton extends StatelessWidget {
  const SortTracksButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);
    final bloc = context.read<TracksBloc>();

    return RpIconButton(
      icon: Icons.sort,
      onPressed: () {
        final sortIndex = SortType.values.indexOf(bloc.state.sortType);
        final nextIndex = (sortIndex + 1) % SortType.values.length;

        bloc.add(SortTracksEvent(sortType: SortType.values[nextIndex]));

        final snackbar = RpSnackbar(context, message: l10n.sortByIndex);

        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
    );
  }
}
