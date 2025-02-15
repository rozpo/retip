import 'package:flutter/material.dart';

import 'app/retip_app.dart';
import 'core/router/retip_router.dart';

void main() async {
  final retipRouter = RetipRouter();

  final retipApp = RetipApp(
    retipRouter: retipRouter,
  );

  runApp(retipApp);
}
