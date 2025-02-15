import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/new/app/presentation/cubits/theme/theme_cubit.dart';

import '../../../core/l10n/retip_l10n.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(l10n.openAppSettings),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context.read<ThemeCubit>().primaryColor = Colors.red;
                  },
                  child: Text(l10n.allow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
