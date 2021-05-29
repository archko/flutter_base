// //import 'package:isolate/isolate.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';

// import '../isolate.dart';
//
// /// usage:
// /// final lb = await loadBalancer;
// //  list = await lb.run<List, String>(decodeList, result);
// /// decodeList should be top level function
// Future<LoadBalancer> loadBalancer = LoadBalancer.create(2, IsolateRunner.spawn);
//
// /// usage:
// /// list = await loadWithBalancer<List, String>(decodeList, result);
// /// decodeList should be top level function
// Future<dynamic> loadWithBalancer<R, T>(Function(T) function, T data) async {
//   final lb = await loadBalancer;
//   return await lb.run<dynamic, T>(function, data);
// }

Future<R> run<R, P>(
    FutureOr<R> Function(dynamic argument) function, P data) async {
  return await compute<dynamic, R>(function, data);
}
