import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/services/repositories/audio_repository.dart';

enum Keys {
  audioRepeatMode,
  audioShuffleMode,
}

class AudioRepositoryImplementation extends AudioRepository {
  final SharedPreferencesProvider sharedPreferencesProvider;

  AudioRepositoryImplementation({
    required this.sharedPreferencesProvider,
  });

  @override
  AudioRepeatMode getRepeatMode() {
    final mode = sharedPreferencesProvider.getString(Keys.audioRepeatMode.name);

    return AudioRepeatMode.fromString(mode ?? '');
  }

  @override
  bool getShuffleMode() {
    return sharedPreferencesProvider.getBool(Keys.audioShuffleMode.name);
  }

  @override
  Future<bool> setRepeatMode(AudioRepeatMode mode) async {
    return await sharedPreferencesProvider.setString(
      Keys.audioRepeatMode.name,
      mode.name,
    );
  }

  @override
  Future<bool> setShuffleMode(bool isEnabled) async {
    return await sharedPreferencesProvider.setBool(
      Keys.audioShuffleMode.name,
      isEnabled,
    );
  }
}
