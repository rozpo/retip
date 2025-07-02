import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/widgets/organisms/rp_app_bar.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_divider.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon_button.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_list_tile.dart';
import 'package:retip/app/presentation/widgets/atoms/spacer.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/debouncer.dart';
import 'package:retip/core/utils/sizer.dart';

import '../../widgets/atoms/spinner_widget.dart';
import 'bloc/search_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({
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

  @override
  Widget build(BuildContext context) {
    _focus.requestFocus();

    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: RpAppBar(
              leading: const Icon(Icons.search),
              actions: [
                const HorizontalSpacer(),
                if (_controller.text.isNotEmpty)
                  RpIconButton(
                    onPressed: () {
                      _controller.text = '';
                      setState(() {});
                      bloc.add(SearchRefreshEvent(''));
                    },
                    icon: Icons.close,
                  ),
                const HorizontalSpacer(),
              ],
              title: SearchBar(
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                focusNode: _focus,
                controller: _controller,
                autoFocus: true,
                shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                backgroundColor:
                    const WidgetStatePropertyAll(Colors.transparent),
                shape: const WidgetStatePropertyAll(LinearBorder.none),
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
                trailing: const [],
              ),
            ),
            body: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchSearchingState) {
                  return const Center(
                    child: SpinnerWidget(),
                  );
                }

                if (state is SearchErrorState) {
                  return Center(
                    child: Text(RetipL10n.of(context).nothingFound),
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
                        preWidget = RpDivider(text: item.toTypeString(context));
                      } else {
                        final currentType = state.media[index];
                        final prevType = state.media[index - 1];

                        if (currentType.runtimeType != prevType.runtimeType) {
                          preWidget = RpDivider(
                            text: item.toTypeString(context),
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
                    .map((e) => RpListTile(
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

                // const header = Padding(
                //   padding: EdgeInsets.only(
                //     left: Sizer.x2,
                //     right: Sizer.x2,
                //     top: Sizer.x2,
                //   ),
                //   child: Row(
                //     children: [
                //       Text('Recent search'),
                //       Expanded(
                //         child: Divider(
                //           indent: Sizer.x1,
                //         ),
                //       ),
                //     ],
                //   ),
                // );
                final header =
                    RpDivider(text: RetipL10n.of(context).recentSearch);

                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
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
