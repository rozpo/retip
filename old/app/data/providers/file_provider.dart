import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class FileProvider {
  Directory? tmpDir;

  Future<Uint8List?> readFile(String fileName) async {
    tmpDir ??= await getTemporaryDirectory();
    final file = File('${tmpDir!.path}/$fileName.png');
    final exists = await file.exists();

    return exists ? await file.readAsBytes() : null;
  }

  Future<File> writeFile(
    String fileName,
    Uint8List bytes, [
    bool override = false,
  ]) async {
    tmpDir ??= await getTemporaryDirectory();
    final file = File('${tmpDir!.path}/$fileName.png');

    if (override || await file.exists() == false) {
      return await file.writeAsBytes(bytes);
    }

    return file;
  }

  Future<String?> getFilePath(String fileName) async {
    tmpDir ??= await getTemporaryDirectory();
    final file = File('${tmpDir!.path}/$fileName.png');
    final exists = await file.exists();

    return exists ? file.path : null;
  }
}
