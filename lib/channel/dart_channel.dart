import 'dart:ui';

import 'package:flutter/services.dart';

typedef DartToNativeCallback = void Function(dynamic result);
typedef Future<dynamic> MethodHandler(MethodCall call);

class DartChannel {
  final _methodChannel = const MethodChannel('com.archko.flutter/flutter_plugin');
  final Set<MethodHandler> _methodHandlers = Set();

  DartChannel() {
    _methodChannel.setMethodCallHandler((MethodCall call) {
      for (MethodHandler handler in _methodHandlers) {
        handler(call);
      }

      return Future.value();
    });
  }

  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    return await _methodChannel.invokeMethod<T>(method, arguments);
  }

  Future<List<T>?> invokeListMethod<T>(String method,
      [dynamic arguments]) async {
    return await _methodChannel.invokeListMethod<T>(method, arguments);
  }

  Future<Map<K, V>?> invokeMapMethod<K, V>(String method,
      [dynamic arguments]) async {
    return await _methodChannel.invokeMapMethod<K, V>(method, arguments);
  }

  VoidCallback addMethodHandler(MethodHandler handler) {
    _methodHandlers.add(handler);

    return () {
      _methodHandlers.remove(handler);
    };
  }
}
