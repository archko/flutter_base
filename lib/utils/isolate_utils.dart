import 'package:isolate/isolate.dart';

Future<LoadBalancer> loadBalancer = LoadBalancer.create(2, IsolateRunner.spawn);
