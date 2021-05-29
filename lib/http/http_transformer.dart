import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/utils/isolate_utils.dart';

class HttpTransformer extends DefaultTransformer {
  HttpTransformer() : super(jsonDecodeCallback: _parseJson);
}

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) async {
  //return await loadWithBalancer<dynamic, String>(_parseAndDecode, text);
  return await compute(_parseAndDecode, text);
}
