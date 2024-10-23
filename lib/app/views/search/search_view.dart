import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/debouncer.dart';

import 'bloc/search_bloc.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final Debouncer _debouncer = Debouncer(const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: SearchBar(
                onChanged: (value) {
                  _debouncer.run(() {
                    context.read<SearchBloc>().add(SearchRefreshEvent(value));
                  });
                },
                hintText: RetipL10n.of(context).searchForMusic,
              ),
              actions: const [
                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.mic),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
