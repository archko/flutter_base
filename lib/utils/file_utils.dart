import 'dart:io';

import 'package:flutter_base/utils/string_utils.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<bool> isExitFile(String? path) async {
    return StringUtils.isEmpty(path) ? await File(path!).exists() : false;
  }

  static Future<bool> saveToFile(String content, String filename) async {
    var cachePath = '${(await getTemporaryDirectory()).path}/$filename';
    print('cachePath:$cachePath');
    File file = File(cachePath);
    file.writeAsString(content);
    return true;
  }

  static Future<String> readFromFile(String filename) async {
    var cachePath = '${(await getTemporaryDirectory()).path}/$filename';
    print('cachePath:$cachePath');
    File file = File(cachePath);
    return file.readAsString();
  }
}
