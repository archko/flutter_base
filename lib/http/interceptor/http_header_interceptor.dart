import 'package:dio/dio.dart';

class HttpHeaderInterceptor extends Interceptor {
  static const httpHeaders = <String, String>{
    'Accept': 'application/json, text/plain, */*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'zh-CN,zh;q=0.9',
    'Connection': 'keep-alive',
    'Content-Type': 'application/json',
    'User-Agent':
        'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
  };

  @override
  onRequest(RequestOptions options) {
    options.headers.addAll(httpHeaders);
    return options;
  }

  @override
  onResponse(Response response) {
    return response;
  }

  @override
  onError(DioError err) {
    return err;
  }
}
