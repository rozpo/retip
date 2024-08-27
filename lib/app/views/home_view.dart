import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RetipL10n.of(context).retip),
      ),
      body: Center(
        child: Text(RetipL10n.of(context).helloWorld),
      ),
    );
  }
}
