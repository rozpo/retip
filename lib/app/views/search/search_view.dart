import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/debouncer.dart';
import 'package:retip/core/utils/sizer.dart';

import 'bloc/search_bloc.dart';

class SearchView extends StatefulWidget {
  final bool Function()? isSelected;

  const SearchView({
    this.isSelected,
    super.key,
  });

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _focus = FocusNode();
  final _debouncer = Debouncer(const Duration(seconds: 1));
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final bloc = SearchBloc();

  void requestFocus() {
    if (widget.isSelected?.call() == true) {
      _focus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    requestFocus();

    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: SearchBar(
                focusNode: _focus,
                controller: _controller,
                autoFocus: false,
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizer.x1),
                  ),
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {});

                  if (value.isEmpty) {
                    _debouncer.cancel(
                      () => bloc.add(SearchRefreshEvent(value)),
                    );
                  }

                  _debouncer.run(() {
                    bloc.add(SearchRefreshEvent(value));
                  });
                },
                hintText: RetipL10n.of(context).searchForMusic,
                trailing: [
                  _controller.text.isEmpty
                      ? const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.mic),
                        )
                      : IconButton(
                          onPressed: () {
                            _controller.text = '';
                            setState(() {});
                            bloc.add(SearchRefreshEvent(''));
                          },
                          icon: const Icon(Icons.close),
                        ),
                ],
              ),
            ),
            body: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchSearchingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is SearchErrorState) {
                  return Center(
                    child: Text(RetipL10n.of(context).noTracks),
                  );
                }

                if (state is SearchSuccessState) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
                    itemCount: state.mediaLength,
                    itemBuilder: (context, index) {
                      Widget preWidget = const SizedBox();
                      final item = state.media[index];

                      if (index == 0) {
                        preWidget = Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizer.x2,
                          ),
                          child: Row(
                            children: [
                              Text(item.toTypeString(context)),
                              const Expanded(
                                child: Divider(
                                  indent: Sizer.x1,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        final currentType = state.media[index];
                        final prevType = state.media[index - 1];

                        if (currentType.runtimeType != prevType.runtimeType) {
                          preWidget = Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizer.x2,
                            ),
                            child: Row(
                              children: [
                                Text(item.toTypeString(context)),
                                const Expanded(
                                  child: Divider(
                                    indent: Sizer.x1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }

                      return Column(
                        children: [
                          preWidget,
                          item.toListTile(context, state.query),
                        ],
                      );
                    },
                  );
                }
                final list = bloc.recentSearch
                    .map((e) => ListTile(
                          title: Text(e),
                          leading: const Icon(Icons.search),
                          onTap: () {
                            _controller.text = e;

                            setState(() {});

                            _debouncer.cancel(
                              () => bloc.add(SearchRefreshEvent(e)),
                            );
                          },
                        ))
                    .toList()
                    .reversed
                    .toList();

                const header = Padding(
                  padding: EdgeInsets.only(
                    left: Sizer.x2,
                    right: Sizer.x2,
                    top: Sizer.x2,
                  ),
                  child: Row(
                    children: [
                      Text('Recent search'),
                      Expanded(
                        child: Divider(
                          indent: Sizer.x1,
                        ),
                      ),
                    ],
                  ),
                );

                return ListView(
                  children: [
                    if (list.isNotEmpty) ...[header],
                    ...list,
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
