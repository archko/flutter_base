import 'package:isolate/isolate.dart';

/// usage:
/// final lb = await loadBalancer;
//  list = await lb.run<List, String>(decodeList, result);
/// decodeList should be top level function
Future<LoadBalancer> loadBalancer = LoadBalancer.create(2, IsolateRunner.spawn);

/// usage:
/// list = await loadWithBalancer<List, String>(decodeList, result);
/// decodeList should be top level function
Future<dynamic> loadWithBalancer<R, T>(Function function, T data) async {
  final lb = await loadBalancer;
  return await lb.run<dynamic, T>(function, data);
}
