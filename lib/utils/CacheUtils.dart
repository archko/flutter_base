import 'dart:async';

import 'package:flutter_base/entity/NewsCache.dart';
import 'package:flutter_base/utils/file_utils.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:flutter_base/utils/json_utils.dart';
import 'package:flutter_base/utils/isolate_utils.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:mmkv/mmkv.dart';

class CacheUtils {
  /// 从缓存文件读取文件内容
  static Future<NewsCache?> readCacheFromCache(String cacheKey) async {
    String? cacheString = MMKV.defaultMMKV().decodeString(cacheKey);
    Logger.d("cacheString:$cacheString");
    if (!StringUtils.isEmpty(cacheString)) {
      NewsCache cache = await run<Token, String>(decodeCache, cacheString!);
      return cache;
    }

    return null;
  }

  static NewsCache decodeCache(String cacheString) {
    return NewsCache.fromJson(JsonUtils.decodeAsMap(cacheString));
  }

  /// 写入缓存配置
  static void writeCache(String cacheKey, String filename, String url) async {
    DateTime _nowDate = DateTime.now();
    String now = "${_nowDate.year}-${_nowDate.month}-${_nowDate.day}";
    NewsCache cache = NewsCache(
      dateString: now,
      filename: filename,
      url: url,
    );
    Logger.d("now:$now, filename:$filename,cache:$cache");

    var json = JsonUtils.toJson(cache);
    MMKV.defaultMMKV().encodeString(cacheKey, json);
  }

  static void writeJsonToCache(String json, String cacheKey, String url) async {
    String filename = "$cacheKey.json";
    writeCache(cacheKey, filename, url);
    FileUtils.saveToFile(json, filename);
  }
}
