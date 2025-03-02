import 'package:flutter/material.dart';

import 'app/retip_app.dart';
import 'core/router/retip_router.dart';

void main() {
  final router = RetipRouter();

  final app = RetipApp(
    router: router,
  );

  runApp(app);
}
