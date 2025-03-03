import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroUsecases {
  final _sharedPreferences = GetIt.I.get<SharedPreferences>();

  disableIntroPage() {
    _sharedPreferences.setBool('intro', false);
  }

  enableIntroPage() {
    _sharedPreferences.setBool('intro', true);
  }

  isIntroPageEnabled() {
    return _sharedPreferences.getBool('intro') ?? true;
  }
}
