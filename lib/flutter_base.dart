import 'dart:async';

import 'package:flutter_base/channel/flutter_bridge.dart';

class FlutterBase {

  static Future<String> get platformVersion async {
    final String version = await FlutterBridge.singleton.channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
