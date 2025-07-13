import 'package:flutter/material.dart';

import '../widgets/icon_buttons/profile_icon_button_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: const [
          ProfileIconButtonWidget(),
        ],
      ),
    );
  }
}
