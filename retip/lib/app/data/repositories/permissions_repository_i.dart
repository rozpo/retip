import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/permissions_repository.dart';

final class PermissionsRepositoryI implements PermissionsRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;

  const PermissionsRepositoryI(this._onAudioQueryProvider);

  @override
  Future<Result<bool>> permissionsCheck() async {
    try {
      final result = await _onAudioQueryProvider.permissionsStatus();

      return ResultSuccess(result);
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }

  @override
  Future<Result<bool>> permissionsRequest() async {
    try {
      final result = await _onAudioQueryProvider.permissionsRequest();

      return ResultSuccess(result);
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }
}
