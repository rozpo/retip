import 'package:retip/app/domain/errors/result.dart';

/// Library repository interface
abstract interface class LibraryRepository {
  /// Scans the library for new media files.
  ///
  /// Returns the number of new media files found.
  Future<Result<int>> scan();
}
