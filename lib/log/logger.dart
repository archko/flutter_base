import 'package:flutter_base/utils/string_utils.dart';

class Logger {
  static const String TAG = "Logger";

  static bool debugable = false;

  static void init({bool debuggable = false}) {
    debugable = debuggable;
  }

  static void d(Object object, {String tag}) {
    if (debugable) {
      printLog(tag, '  v  ', object);
    }
  }

  static void e(Object object, {String tag}) {
    printLog(tag, '  e  ', object);
  }

  static void printLog(String tag, String stag, Object object) {
    if (!StringUtils.isEmpty(tag)) {
      print(tag);
    }

    if (!debugable) {
      return;
    }

    var tempStr = object.toString();
    final int len = tempStr.length;
    final int div = 800;
    int count = len ~/ div;
    if (count > 0) {
      for (int i = 0; i < count; i++) {
        print(tempStr.substring(i * div, (i + 1) * div));
      }
      int mode = len % div;
      if (mode > 0) {
        print(tempStr.substring(div * count, len));
      }
    } else {
      print(tempStr);
    }
  }
}
