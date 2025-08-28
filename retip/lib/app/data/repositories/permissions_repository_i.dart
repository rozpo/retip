import 'package:retip/app/domain/errors/result.dart';

import '../../domain/repositories/permissions_repository.dart';
import '../providers/on_audio_query_provider.dart';

class PermissionsRepositoryI implements PermissionsRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;

  const PermissionsRepositoryI({
    required OnAudioQueryProvider onAudioQueryProvider,
  }) : _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<Result<bool>> checkPermissions() async {
    try {
      final result = await _onAudioQueryProvider.checkPermissions();

      return ResultSuccess(result);
    } catch (e) {
      return ResultFailure(Exception('Failed to check permissions: $e'));
    }
  }

  @override
  Future<Result<bool>> requestPermissions() async {
    try {
      final result = await _onAudioQueryProvider.requestPermissions();

      return ResultSuccess(result);
    } catch (e) {
      return ResultFailure(Exception('Failed to request permissions: $e'));
    }
  }
}
