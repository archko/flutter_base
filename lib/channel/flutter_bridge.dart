import 'dart_channel.dart';

class FlutterBridge {
  static final FlutterBridge _instance = FlutterBridge();

  static FlutterBridge get singleton => _instance;
  final DartChannel _dartToNative = DartChannel();

  DartChannel get channel => _dartToNative;
}
