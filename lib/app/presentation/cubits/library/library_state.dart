part of 'library_cubit.dart';

@immutable
sealed class LibraryState {}

final class LibraryInitial extends LibraryState {}

final class LibraryScanning extends LibraryState {}

final class LibraryScanned extends LibraryState {
  final int count;

  LibraryScanned(this.count);
}
