import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/l10n/retip_l10n.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);

    return Scaffold(
      body: Center(
        child: Text(l10n.grantPermission),
      ),
    );
  }
}
