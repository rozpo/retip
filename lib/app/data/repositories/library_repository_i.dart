import '../../domain/repositories/library_repository.dart';

class LibraryRepositoryI implements LibraryRepository {
  @override
  Future<void> scan() async {
    await Future.delayed(const Duration(seconds: 10));
  }
}
