import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/domain/usecases/intro_usecases.dart';
import 'app/retip_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;

  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerSingleton(sharedPreferences);

  getIt.registerSingleton(IntroUsecases());

  runApp(const RetipApp());
}
