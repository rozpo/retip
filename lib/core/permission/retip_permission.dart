import 'package:on_audio_query/on_audio_query.dart';

mixin RetipPermission {
  static Future<bool> check() async {
    return await OnAudioQuery().permissionsStatus();
  }

  static Future<bool> request() async {
    return await OnAudioQuery().permissionsRequest();
  }

  static Future<bool> checkAndRequest() async {
    return await check() ? true : await request();
  }
}
