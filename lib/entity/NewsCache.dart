import 'package:flutter_base/utils/string_utils.dart';

class NewsCache {
  NewsCache({
    this.dateString,
    this.filename,
    this.url,
    this.key,
    this.name,
  });

  factory NewsCache.fromJson(Map<String, dynamic> json) {
    return NewsCache(
      dateString: json['dateString'],
      filename: json['filename'],
      url: json['url'],
      key: json['key'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["dateString"] = this.dateString;
    map["filename"] = this.filename;
    map["url"] = this.url;
    if (!StringUtils.isEmpty(key)) {
      map["key"] = this.key;
    }
    if (!StringUtils.isEmpty(name)) {
      map["name"] = this.name;
    }
    return map;
  }

  String? dateString;
  String? filename;
  String? url;
  String? key;
  String? name;

  @override
  String toString() {
    return 'NewsCache{dateString: $dateString, filename: $filename, url: $url, key: $key, name: $name}';
  }
}
