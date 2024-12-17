import 'dart:convert';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  static const albumPrefix = 'art_album_';
  static const artistPrefix = 'art_artist_';

  final _prefs = GetIt.I.get<SharedPreferences>();

  Uint8List? getAlbumArtwork(int id) {
    final base64 = _prefs.getString('$albumPrefix$id');

    if (base64 == null) {
      return null;
    }

    return base64Decode(base64);
  }

  Uint8List? getArtistArtwork(int id) {
    final base64 = _prefs.getString('$artistPrefix$id');

    if (base64 == null) {
      return null;
    }

    return base64Decode(base64);
  }

  void setAlbumArtwork(int id, Uint8List bytes) {
    final base64 = base64Encode(bytes);

    _prefs.setString('$albumPrefix$id', base64);
  }

  void setArtistArtwork(int id, Uint8List bytes) {
    final base64 = base64Encode(bytes);

    _prefs.setString('$artistPrefix$id', base64);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool getBool(String key, [bool fallback = false]) {
    return _prefs.getBool(key) ?? fallback;
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }
}
