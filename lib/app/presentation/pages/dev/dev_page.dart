import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dev_view.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DevView(cubit: context.read());
  }
}
