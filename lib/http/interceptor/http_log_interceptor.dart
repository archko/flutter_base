import 'package:dio/dio.dart';
import 'package:flutter_base/log/logger.dart';

class HttpLogInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Logger.d("#------------------ Request Start -----------------#");
    StringBuffer sb = StringBuffer();

    if (options.headers != null && options.headers.length > 0) {
      sb.write("headers:");
      options.headers.forEach((key, value) => sb.write(',$key=$value'));
    }
    if (options.queryParameters != null && options.queryParameters.length > 0) {
      sb.write("\nqueryParameters:");
      options.queryParameters
          .forEach((key, value) => sb.write('$key=$value, '));
    }
    sb.write(
        ",onRequest:method:${options.method},responseType:${options.responseType}, ");
    sb.write("path:${options.path}");
    Logger.d(sb);
    handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.responseType == ResponseType.plain) {
      var contentLength = (response.data as String).length;
      String bodySize = "$contentLength-byte";
      StringBuffer sb = StringBuffer();
      sb.write(response.statusCode);
      sb.write(" ");
      sb.write(response.statusMessage);
      sb.write(" ");
      //sb.write(tookMs);
      //sb.write("ms ");
      sb.write(", ");
      sb.write(bodySize);
      sb.write(" body:");
      sb.write(response.data);
      Logger.d(sb);
    } else {
      Logger.d("response:$response");
    }
    Logger.d("#---------------- Response End -----------------#");

    handler.next(response);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    Logger.d("onError:$err");
    handler.next(err);
  }
}
