import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/atoms/rp_icon_button.dart';
import '../../widgets/atoms/spacer.dart';
import '../../widgets/molecules/rp_divider.dart';
import '../../widgets/organisms/app_bar_widget.dart';
import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/utils/sizer.dart';

import '../../widgets/atoms/spinner_widget.dart';
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
  final _debouncer = Debouncer(const Duration(seconds: 1));
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchBloc>();

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
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
              focusNode: state.focusNode,
              controller: _controller,
              shadowColor: const WidgetStatePropertyAll(Colors.transparent),
              backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
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
    );
  }
}
